# Registers a C++ toolchains
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")


BUILD_FILE_TEMPLATE = """
load("@bazel_tools//tools/cpp:unix_cc_toolchain_config.bzl", "cc_toolchain_config")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

BIN_PREFIX = "{bin_prefix}"

cc_toolchain_config(
    name = "{target_triple}_toolchain_config",
    abi_libc_version = "unknown",
    abi_version = "unknown",
    compiler = "gcc",
    cpu = "{target_cpu}",
    host_system_name = "local",
    target_libc = "unknown",
    target_system_name = "{target_triple}",
    toolchain_identifier = "{target_triple}",
    tool_paths = {{
        "ar": BIN_PREFIX + "ar",
        "cpp": BIN_PREFIX + "g++",
        "gcc": BIN_PREFIX + "gcc",
        "dwp": BIN_PREFIX + "dwp",
        "gcov": BIN_PREFIX + "gcov",
        "ld": BIN_PREFIX + "ld",
        "nm": BIN_PREFIX + "nm",
        "objcopy": BIN_PREFIX + "objcopy",
        "objdump": BIN_PREFIX + "objdump",
        "strip": BIN_PREFIX + "strip",
        "llvm-cov": BIN_PREFIX + "llvm-cov",
    }},
    compile_flags = [
        {compile_flags}
    ],
    link_libs = [
      "-lstdc++",
    ],
)

filegroup(
    name = "all",
    srcs = glob(["**/**"]),
)

cc_toolchain(
    name = "{target_triple}_toolchain",
    # We tell the toolchain, that for every command, all the files are needed
    # This is not ideal, but simple.
    all_files = ":all",
    compiler_files = ":all",
    dwp_files = ":all",
    linker_files = ":all",
    objcopy_files = ":all",
    strip_files = ":all",
    toolchain_config = ":{target_triple}_toolchain_config",
)
"""


TOOLCHAIN_CONFIGS = {
  "aarch64-macos": {
    "aarch64-linux-musl": {
      "target_triple": "aarch64-linux-musl",
      "target_cpu": "aarch64",
      "target_os": "linux",
      "exec_os": "macos",
      "exec_cpu": "aarch64",
      "url": "https://github.com/messense/homebrew-macos-cross-toolchains/releases/download/v11.2.0-1/aarch64-unknown-linux-musl-aarch64-darwin.tar.gz",
      "sha256": "e08ccc332bf75e4c5ef1f559835ec03b0d5df8bb28214b62f1cbd579385eff1f",
      "strip_prefix": "aarch64-unknown-linux-musl",
      "bin_prefix": "bin/aarch64-linux-musl-",
      "compile_flags_template": """
        "-nostdinc++",
        "-isystem", "external/{repo_name}/aarch64-unknown-linux-musl/include/c++/11.2.0",
        "-isystem", "external/{repo_name}/aarch64-unknown-linux-musl/include/c++/11.2.0/aarch64-unknown-linux-musl",
        "-isystem", "external/{repo_name}/aarch64-unknown-linux-musl/sysroot/usr/include/",
      """,
    },
    "x86_64-linux-musl": {
      "target_triple": "x86_64-linux-musl",
      "target_cpu": "x86_64",
      "target_os": "linux",
      "exec_os": "macos",
      "exec_cpu": "aarch64",
      "url": "https://github.com/messense/homebrew-macos-cross-toolchains/releases/download/v11.2.0-1/x86_64-unknown-linux-musl-aarch64-darwin.tar.gz",
      "sha256": "a0ea82a122f33cff29347030e1e569c685ff332b655958e369784fff82e5bb78",
      "strip_prefix": "x86_64-unknown-linux-musl",
      "bin_prefix": "bin/x86_64-unknown-linux-musl-",
      "compile_flags_template": """
        "-nostdinc++",
        "-isystem", "external/{repo_name}/x86_64-unknown-linux-musl/include/c++/11.2.0/",
        "-isystem", "external/{repo_name}/x86_64-unknown-linux-musl/sysroot/usr/include/",
        "-isystem", "external/{repo_name}/x86_64-unknown-linux-musl/include/c++/11.2.0/x86_64-unknown-linux-musl",
      """,
    },
    "armv7-linux-musleabihf": {
      "target_triple": "armv7-linux-musleabihf",
      "target_cpu": "armv7",
      "target_os": "linux",
      "exec_os": "macos",
      "exec_cpu": "aarch64",
      "url": "https://github.com/messense/homebrew-macos-cross-toolchains/releases/download/v11.2.0-1/armv7-unknown-linux-musleabihf-aarch64-darwin.tar.gz",
      "sha256": "cf2b9f8509297704e313e4191e7543c4dc6aff8b9239a878b86f3e7723a69315",
      "strip_prefix": "armv7-unknown-linux-musleabihf",
      "bin_prefix": "bin/armv7-linux-musleabihf-",
      "compile_flags_template": """
        "-nostdinc++",
        "-isystem", "external/{repo_name}/armv7-unknown-linux-musleabihf/include/c++/11.2.0/",
        "-isystem", "external/{repo_name}/armv7-unknown-linux-musleabihf/sysroot/usr/include/",
        "-isystem", "external/{repo_name}/armv7-unknown-linux-musleabihf/include/c++/11.2.0/armv7-unknown-linux-musleabihf",
      """,
    },
  },
  "x86_64-macos": {
    "aarch64-linux-musl": {
      "target_triple": "aarch64-linux-musl",
      "target_cpu": "aarch64",
      "target_os": "linux",
      "exec_os": "macos",
      "exec_cpu": "x86_64",
      "url": "https://github.com/messense/homebrew-macos-cross-toolchains/releases/download/v11.2.0-1/aarch64-unknown-linux-musl-x86_64-darwin.tar.gz",
      "sha256": "4fbe95500c327828b437f380bb15851e9a8126cf95180fbf15b76b78e0322ae3",
      "strip_prefix": "aarch64-unknown-linux-musl",
      "bin_prefix": "bin/aarch64-linux-musl-",
      "compile_flags_template": """
        "-nostdinc++",
        "-isystem", "external/{repo_name}/aarch64-unknown-linux-musl/include/c++/11.2.0",
        "-isystem", "external/{repo_name}/aarch64-unknown-linux-musl/include/c++/11.2.0/aarch64-unknown-linux-musl",
        "-isystem", "external/{repo_name}/aarch64-unknown-linux-musl/sysroot/usr/include/",
      """,
    },
    "aarch64-linux-gnu": {
      "target_triple": "aarch64-linux-gnu",
      "target_cpu": "aarch64",
      "target_os": "linux",
      "exec_os": "macos",
      "exec_cpu": "x86_64",
      "url": "https://github.com/messense/homebrew-macos-cross-toolchains/releases/download/v11.2.0-1/aarch64-unknown-linux-gnu-x86_64-darwin.tar.gz",
      "sha256": "ad7863d0129a7264d501b5e8bbf703b482e42900face4ad2e3e222f5d984fc13",
      "strip_prefix": "aarch64-unknown-linux-gnu",
      "bin_prefix": "bin/aarch64-linux-gnu-",
      "compile_flags_template": """
        "-nostdinc++",
        "-isystem", "external/{repo_name}/aarch64-unknown-linux-gnu/include/c++/11.2.0",
        "-isystem", "external/{repo_name}/aarch64-unknown-linux-gnu/include/c++/11.2.0/aarch64-unknown-linux-gnu",
        "-isystem", "external/{repo_name}/aarch64-unknown-linux-gnu/sysroot/usr/include/",
      """,
    },
    "x86_64-linux-musl": {
      "target_triple": "x86_64-linux-musl",
      "target_cpu": "x86_64",
      "target_os": "linux",
      "exec_os": "macos",
      "exec_cpu": "x86_64",
      "url": "https://github.com/messense/homebrew-macos-cross-toolchains/releases/download/v11.2.0-1/x86_64-unknown-linux-musl-x86_64-darwin.tar.gz",
      "sha256": "4386612402a2f210800feca0ea001aeabade1b6260438b319081209f647e04be",
      "strip_prefix": "x86_64-unknown-linux-musl",
      "bin_prefix": "bin/x86_64-unknown-linux-musl-",
      "compile_flags_template": """
        "-nostdinc++",
        "-isystem", "external/{repo_name}/x86_64-unknown-linux-musl/include/c++/11.2.0/",
        "-isystem", "external/{repo_name}/x86_64-unknown-linux-musl/sysroot/usr/include/",
        "-isystem", "external/{repo_name}/x86_64-unknown-linux-musl/include/c++/11.2.0/x86_64-unknown-linux-musl",
      """,
    },
    "armv7-linux-musleabihf": {
      "target_triple": "armv7-linux-musleabihf",
      "target_cpu": "armv7",
      "target_os": "linux",
      "exec_os": "macos",
      "exec_cpu": "x86_64",
      "url": "https://github.com/messense/homebrew-macos-cross-toolchains/releases/download/v11.2.0-1/armv7-unknown-linux-musleabihf-x86_64-darwin.tar.gz",
      "sha256": "e5bccfcd5c2bd4abe2aa8d9a1f13fdda58cae6142b8570f04de3b87f26e77270",
      "strip_prefix": "armv7-unknown-linux-musleabihf",
      "bin_prefix": "bin/armv7-linux-musleabihf-",
      "compile_flags_template": """
        "-nostdinc++",
        "-isystem", "external/{repo_name}/armv7-unknown-linux-musleabihf/include/c++/11.2.0/",
        "-isystem", "external/{repo_name}/armv7-unknown-linux-musleabihf/sysroot/usr/include/",
        "-isystem", "external/{repo_name}/armv7-unknown-linux-musleabihf/include/c++/11.2.0/armv7-unknown-linux-musleabihf",
      """,
    },
  },
  "x86_64-linux": {
    "aarch64-linux-musl": {
      "target_triple": "aarch64-linux-musl",
      "target_cpu": "aarch64",
      "target_os": "linux",
      "exec_os": "linux",
      "exec_cpu": "x86_64",
      "url": "https://toolchains.bootlin.com/downloads/releases/toolchains/aarch64/tarballs/aarch64--musl--stable-2023.08-1.tar.bz2",
      "sha256": "25767ae9ca70a76e9a71a13c6bc145532066a36d118d8f0ef14bd474784095ce",
      "strip_prefix": "aarch64--musl--stable-2023.08-1",
      "bin_prefix": "bin/aarch64-buildroot-linux-musl-",
      "compile_flags_template": """
        "-nostdinc++",
        "-isystem", "external/{repo_name}/aarch64-buildroot-linux-musl/include/",
        "-isystem", "external/{repo_name}/aarch64-buildroot-linux-musl/include/c++/12.3.0/",
        "-isystem", "external/{repo_name}/aarch64-buildroot-linux-musl/include/c++/12.3.0/aarch64-buildroot-linux-musl",
        "-isystem", "external/{repo_name}/aarch64-buildroot-linux-musl/sysroot/usr/include/",
      """,
    },
    "armv7-linux-musleabihf": {
      "target_triple": "armv7-linux-musleabihf",
      "target_cpu": "armv7",
      "target_os": "linux",
      "exec_os": "linux",
      "exec_cpu": "x86_64",
      "url": "https://toolchains.bootlin.com/downloads/releases/toolchains/armv7-eabihf/tarballs/armv7-eabihf--musl--stable-2023.08-1.tar.bz2",
      "sha256": "4f06ed760d3b2e779f0d8aec73becd21edce9d04560d2fba53549ca8c12f51ba",
      "strip_prefix": "armv7-eabihf--musl--stable-2023.08-1",
      "bin_prefix": "bin/arm-buildroot-linux-musleabihf-",
      "compile_flags_template": """
        "-nostdinc++",
        "-isystem", "external/{repo_name}/arm-buildroot-linux-musleabihf/include/",
        "-isystem", "external/{repo_name}/arm-buildroot-linux-musleabihf/include/c++/12.3.0/",
        "-isystem", "external/{repo_name}/arm-buildroot-linux-musleabihf/include/c++/12.3.0/arm-buildroot-linux-musleabihf/",
        "-isystem", "external/{repo_name}/arm-buildroot-linux-musleabihf/sysroot/usr/include/",
      """,
    },
    "x86_64-linux-musl": {
      "target_triple": "x86_64-linux-musl",
      "target_cpu": "x86_64",
      "target_os": "linux",
      "exec_os": "linux",
      "exec_cpu": "x86_64",
      "url": "https://toolchains.bootlin.com/downloads/releases/toolchains/x86-64/tarballs/x86-64--musl--stable-2023.08-1.tar.bz2",
      "sha256": "e07d11f32a7552bd5155530333d7b3ac9ef5627e10072fd05fbc093cd1f88c50",
      "strip_prefix": "x86-64--musl--stable-2023.08-1",
      "bin_prefix": "bin/x86_64-buildroot-linux-musl-",
      "compile_flags_template": """
        "-nostdinc++",
        "-isystem", "external/{repo_name}/x86_64-buildroot-linux-musl/include/",
        "-isystem", "external/{repo_name}/x86_64-buildroot-linux-musl/include/c++/12.3.0/",
        "-isystem", "external/{repo_name}/x86_64-buildroot-linux-musl/include/c++/12.3.0/x86_64-buildroot-linux-musl",
        "-isystem", "external/{repo_name}/x86_64-buildroot-linux-musl/sysroot/usr/include/",
      """,
    },
  },
}

def _get_config(exec_platform, target_triple, configs):
  config = configs[exec_platform][target_triple]
  processed_config = dict(config)

  if "target_libc" not in processed_config:
    if "musl" in target_triple:
      processed_config["target_libc"] = "//libc:musl"
    else:
      processed_config["target_libc"] = "//libc:gnu"
  
  if "target_sysroot" not in processed_config:
    processed_config["target_sysroot"] = "//sysroot:unknown"

  sanitized_sysroot = processed_config["target_sysroot"].replace("/", "_").replace(":", "-")
  processed_config["repo_name"] = "cc_toolchain_{target_triple}-{exec_platform}_{sanitized_sysroot}".format(
    exec_platform=exec_platform,
    sanitized_sysroot=sanitized_sysroot,
    **config)
  processed_config["compile_flags"] = config["compile_flags_template"].format(**processed_config)

  return processed_config


def cpp_toolchains_from_config(configs):
  for exec_platform in configs:
    for target_triple in configs[exec_platform]:
      processed_config = _get_config(exec_platform, target_triple, configs)
      http_archive(
        name = processed_config["repo_name"],
        sha256 = processed_config["sha256"],
        urls = [processed_config["url"]],
        strip_prefix = processed_config["strip_prefix"],
        build_file_content = BUILD_FILE_TEMPLATE.format(**processed_config),
      )


def register_cpp_toolchains_from_configs(configs, toolchain_package):
  for exec_platform in configs:
    for target_triple in configs[exec_platform]:
      config = _get_config(exec_platform, target_triple, configs)
      native.register_toolchains("{}:{}".format(toolchain_package, config["repo_name"]))


def register_cpp_toolchains():
  cpp_toolchains_from_config(TOOLCHAIN_CONFIGS)
  register_cpp_toolchains_from_configs(TOOLCHAIN_CONFIGS, "//toolchains")


def declare_toolchains_from_config(configs):
  for exec_platform in configs:
    for target_triple in configs[exec_platform]:
      config = _get_config(exec_platform, target_triple, configs)
      toolchain_name = config["repo_name"]
      native.toolchain(
          name = toolchain_name,
          exec_compatible_with = [
              "@platforms//os:{exec_os}".format(**config),
              "@platforms//cpu:{exec_cpu}".format(**config),
          ],
          target_compatible_with = [
              "@platforms//os:{target_os}".format(**config),
              "@platforms//cpu:{target_cpu}".format(**config),
              config["target_libc"],
              config["target_sysroot"],
          ],
          toolchain = "@{repo_name}//:{target_triple}_toolchain".format(**config),
          toolchain_type = "@rules_cc//cc:toolchain_type",
      )


def declare_toolchains():
  declare_toolchains_from_config(TOOLCHAIN_CONFIGS)