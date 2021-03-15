# Automatically generated using Clang.jl

export bpConverterTypesC_Float
export bpConverterTypesC_UInt8, bpConverterTypesC_UInt16, bpConverterTypesC_UInt32, bpConverterTypesC_UInt64
const bpConverterTypesC_UInt8 = Cuchar # UInt8
const bpConverterTypesC_UInt16 = UInt16
const bpConverterTypesC_UInt32 = UInt32
const bpConverterTypesC_UInt64 = Culonglong # UInt64
const bpConverterTypesC_Float = Cfloat # Float32

const bpImageConverterC = Cvoid # Nothing
const bpImageConverterCPtr = Ptr{bpImageConverterC} # Ptr{Nothing}
const bpConverterTypesC_ProgressCallback = Ptr{Cvoid} # Ptr{Nothing}

export bpConverterTypesC_DataType
export bpConverterTypesC_UInt8Type, bpConverterTypesC_UInt16Type, bpConverterTypesC_UInt32Type, bpConverterTypesC_FloatType
@enum bpConverterTypesC_DataType::UInt32 begin
    bpConverterTypesC_UInt8Type = 0
    bpConverterTypesC_UInt16Type = 1
    bpConverterTypesC_UInt32Type = 2
    bpConverterTypesC_FloatType = 3
end

export bpConverterTypesC_ImageExtent
struct bpConverterTypesC_ImageExtent
    mExtentMinX::Cfloat
    mExtentMinY::Cfloat
    mExtentMinZ::Cfloat
    mExtentMaxX::Cfloat
    mExtentMaxY::Cfloat
    mExtentMaxZ::Cfloat
end

const bpConverterTypesC_ImageExtentPtr = Ptr{bpConverterTypesC_ImageExtent}
export bpConverterTypesC_ImageExtentPtr 

export bpConverterTypesC_Dimension
export bpConverterTypesC_DimensionX, bpConverterTypesC_DimensionY, bpConverterTypesC_DimensionZ, bpConverterTypesC_DimensionC, bpConverterTypesC_DimensionT
@enum bpConverterTypesC_Dimension::UInt32 begin
    bpConverterTypesC_DimensionX = 0
    bpConverterTypesC_DimensionY = 1
    bpConverterTypesC_DimensionZ = 2
    bpConverterTypesC_DimensionC = 3
    bpConverterTypesC_DimensionT = 4
end

export bpConverterTypesC_DimensionSequence5D
struct bpConverterTypesC_DimensionSequence5D
    mDimension0::bpConverterTypesC_Dimension
    mDimension1::bpConverterTypesC_Dimension
    mDimension2::bpConverterTypesC_Dimension
    mDimension3::bpConverterTypesC_Dimension
    mDimension4::bpConverterTypesC_Dimension
end

const bpConverterTypesC_DimensionSequence5DPtr = Ptr{bpConverterTypesC_DimensionSequence5D}

export bpConverterTypesC_Size5D 
struct bpConverterTypesC_Size5D
    mValueX::UInt32
    mValueY::UInt32
    mValueZ::UInt32
    mValueC::UInt32
    mValueT::UInt32
end

const bpConverterTypesC_Size5DPtr = Ptr{bpConverterTypesC_Size5D}

export bpConverterTypesC_Index5D
mutable struct bpConverterTypesC_Index5D
    mValueX::UInt32
    mValueY::UInt32
    mValueZ::UInt32
    mValueC::UInt32
    mValueT::UInt32
end

const bpConverterTypesC_Index5DPtr = Ptr{bpConverterTypesC_Index5D}
const bpConverterTypesC_String = Cstring

export tCompressionAlgorithmType
@enum tCompressionAlgorithmType::UInt32 begin
    eCompressionAlgorithmNone = 0
    eCompressionAlgorithmGzipLevel1 = 1
    eCompressionAlgorithmGzipLevel2 = 2
    eCompressionAlgorithmGzipLevel3 = 3
    eCompressionAlgorithmGzipLevel4 = 4
    eCompressionAlgorithmGzipLevel5 = 5
    eCompressionAlgorithmGzipLevel6 = 6
    eCompressionAlgorithmGzipLevel7 = 7
    eCompressionAlgorithmGzipLevel8 = 8
    eCompressionAlgorithmGzipLevel9 = 9
    eCompressionAlgorithmShuffleGzipLevel1 = 11
    eCompressionAlgorithmShuffleGzipLevel2 = 12
    eCompressionAlgorithmShuffleGzipLevel3 = 13
    eCompressionAlgorithmShuffleGzipLevel4 = 14
    eCompressionAlgorithmShuffleGzipLevel5 = 15
    eCompressionAlgorithmShuffleGzipLevel6 = 16
    eCompressionAlgorithmShuffleGzipLevel7 = 17
    eCompressionAlgorithmShuffleGzipLevel8 = 18
    eCompressionAlgorithmShuffleGzipLevel9 = 19
    eCompressionAlgorithmLZ4 = 21
    eCompressionAlgorithmLShuffleLZ4 = 31
end
for i in instances(tCompressionAlgorithmType)
    @eval export $(Symbol(i))
end

export bpConverterTypesC_Options
struct bpConverterTypesC_Options
    mThumbnailSizeXY::UInt32
    mFlipDimensionX::Bool
    mFlipDimensionY::Bool
    mFlipDimensionZ::Bool
    mForceFileBlockSizeZ1::Bool
    mEnableLogProgress::Bool
    mNumberOfThreads::UInt32
    mCompressionAlgorithmType::tCompressionAlgorithmType
    mDisablePyramid::Bool
    bpConverterTypesC_Options(mThumbnailSizeXY, mFlipDimensionX, mFlipDimensionY, mFlipDimensionZ, mForceFileBlockSizeZ1, mEnableLogProgress, mNumberOfThreads, mCompressionAlgorithmType, mDisablePyramid = false) =
        new(mThumbnailSizeXY, mFlipDimensionX, mFlipDimensionY, mFlipDimensionZ, mForceFileBlockSizeZ1, mEnableLogProgress, mNumberOfThreads, mCompressionAlgorithmType, mDisablePyramid)
end

const bpConverterTypesC_OptionsPtr = Ptr{bpConverterTypesC_Options}

export tCompressionAlgorithmType 
struct bpConverterTypesC_Parameter
    mName::bpConverterTypesC_String
    mValue::bpConverterTypesC_String
end
function bpConverterTypesC_Parameter(mName::String, mValue::String)
    bpConverterTypesC_Parameter(Cstring(pointer(mName)),
                                Cstring(pointer(mValue)))
end

export bpConverterTypesC_ParameterSection
struct bpConverterTypesC_ParameterSection
    mName::bpConverterTypesC_String
    mValues::Ptr{bpConverterTypesC_Parameter}
    mValuesCount::UInt32
end

export bpConverterTypesC_Parameters
struct bpConverterTypesC_Parameters
    mValues::Ptr{bpConverterTypesC_ParameterSection}
    mValuesCount::UInt32
end

const bpConverterTypesC_ParametersPtr = Ptr{bpConverterTypesC_Parameters}

export bpConverterTypesC_TimeInfo
struct bpConverterTypesC_TimeInfo
    mJulianDay::UInt32
    mNanosecondsOfDay::Culonglong
end

export bpConverterTypesC_TimeInfos
struct bpConverterTypesC_TimeInfos
    mValues::Ptr{bpConverterTypesC_TimeInfo}
    mValuesCount::UInt32
end

const bpConverterTypesC_TimeInfoVector = Ptr{bpConverterTypesC_TimeInfos}

export bpConverterTypesC_Color
struct bpConverterTypesC_Color
    mRed::Cfloat
    mGreen::Cfloat
    mBlue::Cfloat
    mAlpha::Cfloat
end

export bpConverterTypesC_ColorInfo
struct bpConverterTypesC_ColorInfo
    mIsBaseColorMode::Bool
    mBaseColor::bpConverterTypesC_Color
    mColorTable::Ptr{bpConverterTypesC_Color}
    mColorTableSize::UInt32
    mOpacity::Cfloat
    mRangeMin::Cfloat
    mRangeMax::Cfloat
    mGammaCorrection::Cfloat
end

export bpConverterTypesC_ColorInfos
struct bpConverterTypesC_ColorInfos
    mValues::Ptr{bpConverterTypesC_ColorInfo}
    mValuesCount::UInt32
end
const bpConverterTypesC_ColorInfoVector = Ptr{bpConverterTypesC_ColorInfos}


# Skipping MacroDefinition: BP_IMARISWRITER_DLL_EXPORT __declspec ( dllexport )
# Skipping MacroDefinition: BP_IMARISWRITER_DLL_IMPORT __declspec ( dllimport )
# const BP_IMARISWRITER_DLL_API = BP_IMARISWRITER_DLL_IMPORT
