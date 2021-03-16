# ImarisWriter.jl

Julia bindings for ImarisWriter

## Install
pkg> add  https://github.com/raghavchhetri/ImarisWriter.jl

**DLLS required**
1. bpImarisWriter96.dll
2. hdf5.dll
3. zlib.dll
3. lz4.dll

Before calling `using ImarisWriter` in Julia, make sure DLLs are in .julia directory at \\.julia\packages\ImarisWriter\\...\

Note: DLLs generated using Visual Studio 2019 in Windows 10 can be found here: https://github.com/raghavchhetri/ImarisWriter.jl/tree/main/dependencies
