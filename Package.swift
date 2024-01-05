// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "ggml",
    platforms: [
        .macOS(.v12),
        .iOS(.v14),
        .watchOS(.v4),
        .tvOS(.v14)
    ],
    products: [
        .library(name: "ggml", targets: ["ggml"]),
    ],
    targets: [
        .target(
            name: "ggml",
            path: ".",
            exclude: [],
            sources: [
                "src/ggml.c",
                "src/ggml-alloc.c",
                "src/ggml-backend.c",
                "src/ggml-quants.c",
                "src/ggml-metal.m",
            ],
            resources: [
                .process("src/ggml-metal.metal")
            ],
            publicHeadersPath: "include/ggml",
            cSettings: [
                .unsafeFlags(["-Wno-shorten-64-to-32", "-O3", "-DNDEBUG"]),
                .define("GGML_USE_ACCELERATE"),
                .unsafeFlags(["-fno-objc-arc"]),
                .define("GGML_USE_METAL"),
                .define("ACCELERATE_NEW_LAPACK"),
                .define("ACCELERATE_LAPACK_ILP64")
            ],
            linkerSettings: [
                .linkedFramework("Accelerate")
            ]
        )
    ],
    cxxLanguageStandard: .cxx11
)
