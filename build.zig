const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "c-module",
        .target = target,
        .optimize = optimize,
    });
    exe.addCSourceFile(.{
        .file = .{ .path = "src/main.c" },
        .flags = &.{},
    });
    exe.root_module.addImport("add", b.dependency("add", .{
        .target = target,
        .optimize = optimize,
    }).module("add"));
    b.installArtifact(exe);

    const exe_zig = b.addExecutable(.{
        .name = "c-module-zig",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe_zig.root_module.addImport("add", b.dependency("add", .{
        .target = target,
        .optimize = optimize,
    }).module("add"));
    b.installArtifact(exe_zig);
}
