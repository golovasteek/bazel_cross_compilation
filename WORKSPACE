load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "rules_rust",
    sha256 = "9d04e658878d23f4b00163a72da3db03ddb451273eb347df7d7c50838d698f49",
    urls = ["https://github.com/bazelbuild/rules_rust/releases/download/0.26.0/rules_rust-v0.26.0.tar.gz"],
)

load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_repository_set")

rules_rust_dependencies()

rust_repository_set(
  edition = "2021",
  name = "rust_repository_set_x86_64-linux-musl",
  exec_triple = "x86_64-unknown-linux-gnu",
  target_settings = [
    "//:musl",
  ],
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

load("//toolchains:cpp_toolchains.bzl", "register_cpp_toolchain")
register_cpp_toolchain("aarch64-linux-musl")
register_cpp_toolchain("x86_64-linux-musl")
register_cpp_toolchain("armv7-linux-musleabihf")
