const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const os = b.addExecutable(.{
        .name = "os.bin",
        .target = target,
        .optimize = optimize,
    });
    const kernel = b.addObject(.{
        .name = "kernel",
        .root_source_file = b.path("src/kmain.zig"),
        .target = target,
        .optimize = optimize,
    });
    os.addObject(kernel);
    os.setLinkerScript(b.path("src/linker.ld"));
    b.installArtifact(os);
}
