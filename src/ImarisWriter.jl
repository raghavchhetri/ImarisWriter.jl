module ImarisWriter

using Libdl
#using Lz4_jll, Zlib_jll, HDF5_jll

# Need the following DLLs
# 1. bpImarisWriter96.dll
# 2. lz4.dll
# 3. zlib.dll
# 4. hdf5.dll


# Write your package code here.

include("imariswriter_common.jl")
include("imariswriter_api.jl")

const bpImarisWriter96_path = joinpath( @__DIR__(), "..", "bpImarisWriter96.dll")
const bpImarisWriter96 = :bpImarisWriter96

function __init__()
    global bpImarisWriter96_h
    bpImarisWriter96_h =  dlopen( bpImarisWriter96_path )
end

end
