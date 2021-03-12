using Clang

# Currently https://github.com/JaneliaSciComp/ImarisWriter/tree/disablePyramidOption
const IMARISWRITER_INCLUDE = raw"C:\Users\kittisopikulm\source\repos\ImarisWriter\interfaceC"
# Might need to focus this on bpImageConverterInterfaceC.h or include <stdbool.h> before loading bpConverterTypesC.h
const IMARISWRITER_HEADERS = [joinpath(IMARISWRITER_INCLUDE, header) for header in readdir(IMARISWRITER_INCLUDE) if endswith(header, ".h")]

wc = init(; headers = IMARISWRITER_HEADERS,
            output_file = joinpath(@__DIR__, "imariswriter_api.jl"),
            common_file = joinpath(@__DIR__, "imariswriter_common.jl"),
            clang_includes = vcat(IMARISWRITER_INCLUDE, CLANG_INCLUDE),
            clang_args = ["-I", joinpath(IMARISWRITER_INCLUDE, "..")],
            header_wrapped = (root, current)->root == current,
            header_library = x->"bpImarisWriter96",
            clang_diagnostics = true,
            )

run(wc)