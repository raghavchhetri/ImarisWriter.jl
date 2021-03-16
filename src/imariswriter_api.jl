# Julia wrapper for header: bpConverterTypesC.h
# Automatically generated using Clang.jl

# Julia wrapper for header: bpImageConverterInterfaceC.h
# Automatically generated using Clang.jl


export bpImageConverterC_Create, bpImageConverterC_Destroy, bpImageConverterC_GetLastException, bpImageConverterC_NeedCopyBlock,bpImageConverterC_Finish,
    bpImageConverterC_CopyBlockUInt8, bpImageConverterC_CopyBlockUInt16, bpImageConverterC_CopyBlockUInt32, bpImageConverterC_CopyBlockFloat

function bpImageConverterC_Create(
    aDataType,          aImageSize,       aSample,
    aDimensionSequence, aFileBlockSize,   aOutputFile,
    aOptions,           aApplicationName, aApplicationVersion,
    aProgressCallback,  aCallbackUserData)

    ccall((:bpImageConverterC_Create, bpImarisWriter96), bpImageConverterCPtr,
    (bpConverterTypesC_DataType,               bpConverterTypesC_Size5DPtr, bpConverterTypesC_Size5DPtr,
     bpConverterTypesC_DimensionSequence5DPtr, bpConverterTypesC_Size5DPtr, bpConverterTypesC_String,
     bpConverterTypesC_OptionsPtr,             bpConverterTypesC_String,    bpConverterTypesC_String,
     bpConverterTypesC_ProgressCallback,       Ptr{Cvoid}),
     aDataType,                                aImageSize,                  aSample,
     aDimensionSequence,                       aFileBlockSize,              aOutputFile,
     aOptions,                                 aApplicationName,            aApplicationVersion,
     aProgressCallback,                        aCallbackUserData)
end

function bpImageConverterC_Create(
    aDataType, aImageSize::Size5D, aSample::Size5D,
    aDimensionSequence::DimensionSequence5D, aFileBlockSize::Size5D, aOutputFile,
    aOptions::Options, aApplicationName::String, aApplicationVersion::String,
    aProgressCallback, aCallbackUserData
)
    bpImageConverterC_Create(
        aDataType, Ref(aImageSize), Ref(aSample),
        Ref(aDimensionSequence), Ref(aFileBlockSize),
        aOutputFile, Ref(aOptions),
        aApplicationName, aApplicationVersion,
        aProgressCallback, Ref(aCallbackUserData)
    )
end
const create = bpImageConverterC_Create

function bpImageConverterC_Destroy(aImageConverterC)
    ccall((:bpImageConverterC_Destroy, bpImarisWriter96), Cvoid, (bpImageConverterCPtr,), aImageConverterC)
end
const destroy = bpImageConverterC_Destroy

function bpImageConverterC_GetLastException(aImageConverterC)
    ccall((:bpImageConverterC_GetLastException, bpImarisWriter96), Cstring, (bpImageConverterCPtr,), aImageConverterC)
end

function bpImageConverterC_NeedCopyBlock(aImageConverterC, aBlockIndex)
    ccall((:bpImageConverterC_NeedCopyBlock, bpImarisWriter96), Bool, (bpImageConverterCPtr, bpConverterTypesC_Index5DPtr), aImageConverterC, aBlockIndex)
end
const needCopyBlock = bpImageConverterC_NeedCopyBlock

function bpImageConverterC_CopyBlockUInt8(aImageConverterC, aFileDataBlock, aBlockIndex)
    ccall((:bpImageConverterC_CopyBlockUInt8, bpImarisWriter96), Cvoid,
    (bpImageConverterCPtr, Ptr{bpConverterTypesC_UInt8}, bpConverterTypesC_Index5DPtr),
     aImageConverterC,     aFileDataBlock,               aBlockIndex)
end

function bpImageConverterC_CopyBlockUInt16(aImageConverterC, aFileDataBlock, aBlockIndex)
    ccall((:bpImageConverterC_CopyBlockUInt16, bpImarisWriter96), Cvoid,
    (bpImageConverterCPtr, Ptr{bpConverterTypesC_UInt16}, bpConverterTypesC_Index5DPtr),
     aImageConverterC,     aFileDataBlock,                aBlockIndex)
end

function bpImageConverterC_CopyBlockUInt32(aImageConverterC, aFileDataBlock, aBlockIndex)
    ccall((:bpImageConverterC_CopyBlockUInt32, bpImarisWriter96), Cvoid,
    (bpImageConverterCPtr, Ptr{bpConverterTypesC_UInt32}, bpConverterTypesC_Index5DPtr),
         aImageConverterC, aFileDataBlock,                aBlockIndex)
end

function bpImageConverterC_CopyBlockFloat(aImageConverterC, aFileDataBlock, aBlockIndex)
    ccall((:bpImageConverterC_CopyBlockFloat, bpImarisWriter96), Cvoid,
    (bpImageConverterCPtr, Ptr{bpConverterTypesC_Float}, bpConverterTypesC_Index5DPtr),
         aImageConverterC, aFileDataBlock,               aBlockIndex)
end

# High level copyBlock
# aFileDataBlock must be an AbstractArray for which `pointer` is applicable
copyBlock(aImageConverterC, aFileDataBlock::AbstractArray{UInt8}, aBlockIndex::Index5D) =
    GC.@preserve aFileDataBlock bpImageConverterC_CopyBlockUInt8( aImageConverterC, pointer(aFileDataBlock), Ref(aBlockIndex))
copyBlock(aImageConverterC, aFileDataBlock::AbstractArray{UInt16}, aBlockIndex::Index5D) =
    GC.@preserve aFileDataBlock bpImageConverterC_CopyBlockUInt16(aImageConverterC, pointer(aFileDataBlock), Ref(aBlockIndex))
copyBlock(aImageConverterC, aFileDataBlock::AbstractArray{UInt32}, aBlockIndex::Index5D) =
    GC.@preserve aFileDataBlock bpImageConverterC_CopyBlockUInt32(aImageConverterC, pointer(aFileDataBlock), Ref(aBlockIndex))
copyBlock(aImageConverterC, aFileDataBlock::AbstractArray{Float32}, aBlockIndex::Index5D) =
    GC.@preserve aFileDataBlock bpImageConverterC_CopyBlockFloat( aImageConverterC, pointer(aFileDataBlock), Ref(aBlockIndex))

# Low level copyBlock
# Pass in pointers or references for aFileDataBlock and aBlockIndex
copyBlock(aImageConverterC, aFileDataBlock::Ptr{UInt8}, aBlockIndex) =
    bpImageConverterC_CopyBlockUInt8( aImageConverterC, aFileDataBlock, aBlockIndex)
copyBlock(aImageConverterC, aFileDataBlock::Ptr{UInt16}, aBlockIndex) =
    bpImageConverterC_CopyBlockUInt16(aImageConverterC, aFileDataBlock, aBlockIndex)
copyBlock(aImageConverterC, aFileDataBlock::Ptr{UInt32}, aBlockIndex) =
    bpImageConverterC_CopyBlockUInt32(aImageConverterC, aFileDataBlock, aBlockIndex)
copyBlock(aImageConverterC, aFileDataBlock::Ptr{Float32}, aBlockIndex) =
    bpImageConverterC_CopyBlockFloat( aImageConverterC, aFileDataBlock, aBlockIndex)



function bpImageConverterC_Finish(aImageConverterC, aImageExtent, aParameters, aTimeInfoPerTimePoint, aColorInfoPerChannel, aAutoAdjustColorRange)
    ccall((:bpImageConverterC_Finish, bpImarisWriter96), Cvoid,
    (bpImageConverterCPtr,             bpConverterTypesC_ImageExtentPtr,  bpConverterTypesC_ParametersPtr,
     bpConverterTypesC_TimeInfoVector, bpConverterTypesC_ColorInfoVector, Bool),
     aImageConverterC,                 aImageExtent,                      aParameters,
     aTimeInfoPerTimePoint,            aColorInfoPerChannel,              aAutoAdjustColorRange)
end

function bpImageConverterC_Finish(
    aImageConverterC::Ptr{Nothing},
    aImageExtent::ImageExtent,
    aParameters::Vector{ParameterSection},
    aTimeInfoPerTimePoint::Vector{TimeInfo},
    aColorInfoPerChannel::Vector{ColorInfo},
    aAutoAdjustColorRange::Bool)

    ps = bpConverterTypesC_ParameterSection.(aParameters)
    vParametersC = bpConverterTypesC_Parameters(
        pointer( ps ),
        length(  ps )
    )

    #ti = bpConverterTypesC_TimeInfo.(aTimeInfoPerTimePoint)
    ti = aTimeInfoPerTimePoint
    vTimeInfoPerTimePointC = bpConverterTypesC_TimeInfos(
        pointer( ti ),
        length(  ti )
    )

    ci = bpConverterTypesC_ColorInfo.(aColorInfoPerChannel)
    vColorInfoPerChannelC = bpConverterTypesC_ColorInfos(
        pointer( ci ),
        length(  ci )
    )

    GC.@preserve aParameters aTimeInfoPerTimePoint aColorInfoPerChannel ps ci begin
    bpImageConverterC_Finish(
        aImageConverterC,
        Ref(aImageExtent),
        Ref(vParametersC),
        Ref(vTimeInfoPerTimePointC),
        Ref(vColorInfoPerChannelC),
        aAutoAdjustColorRange)
    end
end
const finish = bpImageConverterC_Finish

# Accessory functions, originally from test program

function numBlocks(aSize, aBlockSize)
    return (aSize + aBlockSize - 1) ÷ aBlockSize
end

function checkErrors(aConverter)
    vException = bpImageConverterC_GetLastException(aConverter)
    if(vException != C_NULL)
        error("ImarisWriter Error: " * unsafe_string(vException))
    end
end