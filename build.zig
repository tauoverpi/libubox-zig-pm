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

    for (libubox_h) |header| lib.installHeader(header, b.fmt("libubox/{s}", .{header}));
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

const libubox_h: []const []const u8 = &.{
    "assert.h",
    "avl-cmp.h",
    "avl.h",
    "blob.h",
    "blobmsg.h",
    "blobmsg_json.h",
    "json_script.h",
    "kvlist.h",
    "list.h",
    "md5.h",
    "runqueue.h",
    "safe_list.h",
    "ulog.h",
    "uloop.h",
    "usock.h",
    "ustream.h",
    "utils.h",
    "vlist.h",
};
