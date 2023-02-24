const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "libubox",
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });

    lib.linkLibC();
    lib.addCSourceFiles(libubox_src, &.{
        "-Wall",                     "-Werror",
        "-Wformat",                  "-Werror=format-security",
        "-Werror=format-nonliteral", "-Wmissing-declarations",
        "-Wno-unused-parameter",     "-std=gnu99",
        "-g3",
    });

    lib.install();
}

const libubox_src = &.{
    "avl.c",
    "avl-cmp.c",
    "blob.c",
    "blobmsg.c",
    "uloop.c",
    "usock.c",
    "ustream.c",
    "ustream-fd.c",
    "vlist.c",
    "utils.c",
    "safe_list.c",
    "runqueue.c",
    "md5.c",
    "kvlist.c",
    "ulog.c",
    "base64.c",
};
