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

function bpImageConverterC_Destroy(aImageConverterC)
    ccall((:bpImageConverterC_Destroy, bpImarisWriter96), Cvoid, (bpImageConverterCPtr,), aImageConverterC)
end

function bpImageConverterC_GetLastException(aImageConverterC)
    ccall((:bpImageConverterC_GetLastException, bpImarisWriter96), Cstring, (bpImageConverterCPtr,), aImageConverterC)
end

function bpImageConverterC_NeedCopyBlock(aImageConverterC, aBlockIndex)
    ccall((:bpImageConverterC_NeedCopyBlock, bpImarisWriter96), Bool, (bpImageConverterCPtr, bpConverterTypesC_Index5DPtr), aImageConverterC, aBlockIndex)
end

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

function bpImageConverterC_Finish(aImageConverterC, aImageExtent, aParameters, aTimeInfoPerTimePoint, aColorInfoPerChannel, aAutoAdjustColorRange)
    ccall((:bpImageConverterC_Finish, bpImarisWriter96), Cvoid,
    (bpImageConverterCPtr,             bpConverterTypesC_ImageExtentPtr,  bpConverterTypesC_ParametersPtr,
     bpConverterTypesC_TimeInfoVector, bpConverterTypesC_ColorInfoVector, Bool),
     aImageConverterC,                 aImageExtent,                      aParameters,
     aTimeInfoPerTimePoint,            aColorInfoPerChannel,              aAutoAdjustColorRange)
end
