"""
    SimpleTestProgram

    Executable test program for ImarisWriter.jl
    Using or importing this module will execute generate three IMS files:
    0. out_0.ims generated by `testConvert(0)` with progress callback
    1. out_1.ims generated by `testConvert(1)` with progress callback
    2. out_2.ims generated by `testConvertActual(2)` without progress callback

    Based loosely upon https://github.com/imaris/ImarisWriterTest/blob/master/testC/bpImarisWriter96TestProgram.c
"""
module SimpleTestProgram
    using ImarisWriter
    # Manually import shorthand types
    import ImarisWriter: Options, Size5D, Parameter, ParameterSection, DimensionSequence5D
    import ImarisWriter: Color, ColorInfo, ImageExtent, Index5D, TimeInfo

    # For progress callback
    struct bpCallbackData
        handle::Ptr{Nothing} # Base.AsyncCondition.handle
        aProgress::bpConverterTypesC_Float # Passed in from callback
        aTotalBytesWritten::bpConverterTypesC_UInt64 # Passed in from callback
        mImageIndex::UInt32 # User parameter
        mProgress::Int32 # User parameter
    end

    """
        progressCallbackActual(vCallbackData::bpCallbackData)

        Actually handles the callback from ImarisWriter and updates status
    """
    function progressCallbackActual(vCallbackData::bpCallbackData)
        # Extract data passed in from callback
        aProgress = vCallbackData.aProgress
        aTotalBytesWritten = vCallbackData.aTotalBytesWritten

        vProgress = round(Int,aProgress * 100)

        if(vProgress - vCallbackData.mProgress < 5)
            return nothing
        end

        vImageIndex = vCallbackData.mImageIndex
        if aTotalBytesWritten < 10 * 1024 * 1024
            println("Progress image $vImageIndex: $vProgress% [$(aTotalBytesWritten ÷ 1024) KB]")
        else
            println("Progress image $vImageIndex: $vProgress% [$(aTotalBytesWritten ÷ (1024*1024)) MB]")
        end
        # vCallbackData.mProgress[] = vProgress
    end

    """
        progressCallback(aProgress, aTotalBytesWritten, aUserData)

        ImarisWriter calls back from an outside thread, and this is not thread safe.
        aUserData is a Ptr{Nothing} that points to a struct that must be isbits && isimmutable
    """
    function progressCallback(aProgress::Float32, aTotalBytesWritten::UInt64, aUserData::Ptr{Nothing})
        # Based on https://github.com/JuliaGPU/OpenCL.jl/blob/master/src/event.jl
        ptr = convert(Ptr{bpCallbackData}, aUserData)
        val = unsafe_load(ptr)
        handle = val.handle

        val = bpCallbackData(val.handle, aProgress, aTotalBytesWritten, val.mImageIndex, val.mProgress)
        unsafe_store!(ptr, val)
        ccall(:uv_async_send, Nothing, (Ptr{Nothing},), handle)
        # ccall(:printf, Cint, (Cstring,Ptr{Nothing}), "Hello World %d \n", handle)
        return nothing
    end

    # C function pointer for callback
    const aProgressCallback = @cfunction(progressCallback, Nothing, (bpConverterTypesC_Float, bpConverterTypesC_UInt64, Ptr{Nothing}) )

    # Callback Task
    function callbackTask(cond, aCallbackUserData)
        run = true
        while(run)
            try
                #println("Waiting... $(cond.handle)")
                wait(cond)
                data = aCallbackUserData[]
                progressCallbackActual(data)
            catch
                run = false
                # rethrow()
            end
        end
        close(cond)
        println("Exiting callback loop for test $aTestIndex")
    end

    """
        testConvert(aTestIndex = 0)

        Test with progress callback. Complex.
    """
    function testConvert(aTestIndex = 0)
        println("testConvert($aTestIndex)")

        # Setup callback
        cond = Base.AsyncCondition()
        # println("This is the beginning $aTestIndex: $(cond.handle)")
        aCallbackUserData = Ref( bpCallbackData(cond.handle, 0.0, 0, aTestIndex, -5) )
        ptr = Base.unsafe_convert(Ptr{Nothing}, aCallbackUserData)

        # Callback task to receive callback from foreign thread
        t = @async callbackTask(cond, aCallbackUserData)

        #Start actual program, preserving cond and aCallbackUserData from garbage collection
        GC.@preserve cond aCallbackUserData testConvertActual(aTestIndex, aCallbackUserData)

        # Clean up callback
        progressCallbackActual(aCallbackUserData[])
        close(cond)
        t
    end

    """
        testConvertActual(aTestIndex = 0, aCallbackuserData = C_NULL)

        Test program without progress callback. Simpler.
    """
    function testConvertActual(aTestIndex = 0, aCallbackUserData = C_NULL)
        ### Setup

        aDataType = UInt8
        aImageSize = Size5D(X = 512, Y = 512, Z = 32, C = 4, T = 2)
        vVoxelSizeXY = 1.4
        vVoxelSizeZ = 5.4
        aImageExtent = ImageExtent(
            X = (0, aImageSize.mValueX * vVoxelSizeXY),
            Y = (0, aImageSize.mValueY * vVoxelSizeXY),
            Z = (0, aImageSize.mValueZ)
        )
        aSample = Size5D()
        aDimensionSequence = DimensionSequence5D(:X, :Y, :Z, :C, :T)
        aBlockSize = Size5D(X = 256, Y = 256, Z = 8)
        aOutputFile = "./out_$aTestIndex.ims"

        # ImarisWriter Options
        aOptions = Options(
            mEnableLogProgress = aCallbackUserData != C_NULL, # Disable callback logging if second argument is a null pointer
            mNumberOfThreads = length(Sys.cpu_info()) ÷ 2, # Uses half of the logical processors, which should be # of cores
            mDisablePyramid = false # Create multiresolution pyramid
        )

        aApplicationName = "simpleTestProgram.jl"
        aApplicationVersion = "1.0.0"

        ### Create File and Handle

        vConverter = ImarisWriter.create(
            aDataType, aImageSize, aSample,
            aDimensionSequence, aBlockSize,
            aOutputFile, aOptions,
            aApplicationName, aApplicationVersion,
            aProgressCallback, aCallbackUserData
        )
        ImarisWriter.checkErrors(vConverter)

        ### Write Blocks

        vBlockSize = aBlockSize.mValueX * aBlockSize.mValueY * aBlockSize.mValueZ * aBlockSize.mValueC * aBlockSize.mValueT
        vData = Vector{UInt8}(undef, vBlockSize)
        for vIndex in eachindex(vData)
            vData[vIndex] = mod(vIndex-1, 256)
        end

        vNBlocksX = ImarisWriter.numBlocks(aImageSize.mValueX, aBlockSize.mValueX)
        vNBlocksY = ImarisWriter.numBlocks(aImageSize.mValueY, aBlockSize.mValueY)
        vNBlocksZ = ImarisWriter.numBlocks(aImageSize.mValueZ, aBlockSize.mValueZ)
        vNBlocksC = ImarisWriter.numBlocks(aImageSize.mValueC, aBlockSize.mValueC)
        vNBlocksT = ImarisWriter.numBlocks(aImageSize.mValueT, aBlockSize.mValueT)

        aBlockIndex = Index5D()

        for aBlockIndex.mValueC = 0:vNBlocksC-1,
            aBlockIndex.mValueT = 0:vNBlocksT-1,
            aBlockIndex.mValueZ = 0:vNBlocksZ-1,
            aBlockIndex.mValueY = 0:vNBlocksY-1,
            aBlockIndex.mValueX = 0:vNBlocksX-1

            ImarisWriter.copyBlock(vConverter, vData, aBlockIndex)
            ImarisWriter.checkErrors(vConverter)
            yield()
        end

        ### Write Metadata

        vNumberOfOtherSections = 1
        vNumberOfSections = vNumberOfOtherSections + aImageSize.mValueC
        vParameterSections = Vector{ParameterSection}(undef,vNumberOfSections)
        vUnitParameter = Parameter("Unit", "um")
        vImageSection = ParameterSection("Image", vUnitParameter)
        vParameterSections[1] = vImageSection
        vNumberOfParametersPerChannel = 3
        for vC = 1:aImageSize.mValueC
            vChannelParameters = Vector{Parameter}(undef, vNumberOfParametersPerChannel)
            vChannelParameters[1] = Parameter("Name", vC == 0 ? "First channel" : vC == 1 ? "Second channel" : vC == 2 ? "Third channel" : "Other channel")
            vChannelParameters[2] = Parameter("LSMEmissionWavelength", "700")
            vChannelParameters[3] = Parameter("OtherChannelParameter", "OtherChannelValue")
            vParameterSections[vNumberOfOtherSections + vC] = ParameterSection("Channel $vC", vChannelParameters)
        end

        #aParameters = bpConverterTypesC_Parameters(vParameterSections, vNumberOfSections)

        vTimeInfos = Vector{TimeInfo}(undef,aImageSize.mValueT)
        for vT = 1:aImageSize.mValueT
            vSeconds = vT + 4 + 60 * (27 + 60 *15)
            vTimeInfos[vT] = TimeInfo( 2458885, vSeconds * 1_000_000_000 )
        end
        # Convert vTimesInfos to a pointer
        #aTimeInfoPerTimePoint = bpConverterTypesC_TimeInfos(vTimeInfos,  aImageSize.mValueT)

        vColorInfos = Vector{ColorInfo}(undef, aImageSize.mValueC)
        for vC = 1:aImageSize.mValueC
            vColorInfos[vC] = ColorInfo(
                Color(
                    (vC - 1 % 3) == 0 ? 1 : 0, # mRed
                    (vC - 1 % 3) == 1 ? 1 : 0, # mGreen
                    (vC - 1 % 3) == 2 ? 1 : 0, # mBlue
                    1
                ) # mBaseColor
            )
        end
        # Make vColorInfos into a pointer
        #aColorInfoPerChannel = bpConverterTypesC_ColorInfos(vColorInfos, aImageSize.mValueC)

        aAutoAdjustColorRange = true

        ImarisWriter.finish(vConverter,
            aImageExtent, vParameterSections, vTimeInfos,
            vColorInfos, aAutoAdjustColorRange
        )
        ImarisWriter.checkErrors(vConverter)

        ImarisWriter.destroy(vConverter)

    end

    function __init__()
        testConvert(0)
        testConvert(1)
        println("No callback test")
        testConvertActual(2)
    end

end