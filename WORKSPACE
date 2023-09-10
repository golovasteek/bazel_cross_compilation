load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "rules_rust",
    sha256 = "9d04e658878d23f4b00163a72da3db03ddb451273eb347df7d7c50838d698f49",
    urls = ["https://github.com/bazelbuild/rules_rust/releases/download/0.26.0/rules_rust-v0.26.0.tar.gz"],
)

load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_register_toolchains")

rules_rust_dependencies()

rust_register_toolchains(
  edition = "2021",
  extra_target_triples = [
    "x86_64-unknown-linux-musl",
    "armv7-unknown-linux-musleabihf",
    "aarch64-unknown-linux-musl",
  ],
)

load("@rules_rust//crate_universe:repositories.bzl", "crate_universe_dependencies")

crate_universe_dependencies()

load("@rules_rust//crate_universe:defs.bzl", "crates_repository")

crates_repository(
    name = "crate_index",
    cargo_lockfile = "//rust:Cargo.lock",
    manifests = [
      "//rust:Cargo.toml",
      "//rust/pure_rust_example:Cargo.toml",
    ],
)

load("@crate_index//:defs.bzl", "crate_repositories")

crate_repositories()

http_archive(
    name = "aarch64-unknown-linux-musl",
    sha256 = "4fbe95500c327828b437f380bb15851e9a8126cf95180fbf15b76b78e0322ae3",
    urls = ["https://github.com/messense/homebrew-macos-cross-toolchains/releases/download/v11.2.0-1/aarch64-unknown-linux-musl-x86_64-darwin.tar.gz"],
    strip_prefix = "aarch64-unknown-linux-musl",
    build_file = "//toolchains/thirdparty/aarch64-unknown-linux-musl:toolchain.BUILD.bazel",
)

http_archive(
    name = "x86_64-unknown-linux-musl",
    sha256 = "4386612402a2f210800feca0ea001aeabade1b6260438b319081209f647e04be",
    urls = ["https://github.com/messense/homebrew-macos-cross-toolchains/releases/download/v11.2.0-1/x86_64-unknown-linux-musl-x86_64-darwin.tar.gz"],
    strip_prefix = "x86_64-unknown-linux-musl",
    build_file = "//toolchains/thirdparty/x86_64-unknown-linux-musl:toolchain.BUILD.bazel",
)

http_archive(
    name = "armv7-unknown-linux-musleabihf",
    sha256 = "4f06ed760d3b2e779f0d8aec73becd21edce9d04560d2fba53549ca8c12f51ba",
    urls = ["https://toolchains.bootlin.com/downloads/releases/toolchains/armv7-eabihf/tarballs/armv7-eabihf--musl--stable-2023.08-1.tar.bz2"],
    strip_prefix = "armv7-eabihf--musl--stable-2023.08-1",
    build_file = "//toolchains/thirdparty/armv7-unknown-linux-musleabihf:toolchain.BUILD.bazel",
)

register_toolchains(
    "@x86_64-unknown-linux-musl//:x86_64-linux-musl",
    "@armv7-unknown-linux-musleabihf//:armv7-unknown-linux-musleabihf",
    "@aarch64-unknown-linux-musl//:aarch64-linux-musl",
)

