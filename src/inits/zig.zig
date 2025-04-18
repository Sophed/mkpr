const std = @import("std");
const fs = std.fs;
const print = std.debug.print;
const cmd = @import("../util/cmd.zig");
const write = @import("../util/write.zig");
const pretty = @import("../util/pretty.zig");

const justfile = @embedFile("../templates/zig/justfile");
const gitignore = @embedFile("../templates/zig/.gitignore");
const buildZig = @embedFile("../templates/zig/build.zig");
const buildZigZon = @embedFile("../templates/zig/build.zig.zon");
const mainZig = @embedFile("../templates/zig/src/main.zig");

pub fn init(allocator: std.mem.Allocator, project_name: []const u8) void {
    var argv = [_][]const u8{ "zig", "version" };
    cmd.run(allocator, &argv) catch {
        print(pretty.ERR_PREFIX ++ "Zig is not installed - please install it to use this template\n", .{});
        std.process.exit(1);
        return;
    };

    print(pretty.GREEN ++ "󰣪 creating Zig project" ++ pretty.RESET ++ ": {s}\n", .{project_name});
    setup(allocator, project_name) catch |err| {
        print(pretty.ERR_PREFIX ++ "{}\n", .{err});
        std.process.exit(1);
        return;
    };
}

fn setup(allocator: std.mem.Allocator, project_name: []const u8) !void {
    print("creating project directory\n", .{});
    try fs.cwd().makeDir(project_name);
    try std.posix.chdir(project_name);

    print("writing meta files\n", .{});
    try write.writeFile("justfile", justfile);
    try write.writeFile(".gitignore", gitignore);
    const build_script = try pretty.replace(allocator, buildZig, "{{NAME}}", project_name);
    try write.writeFile("build.zig", build_script);
    const module_details = try pretty.replace(allocator, buildZigZon, "{{NAME}}", project_name);
    try write.writeFile("build.zig.zon", module_details);
    try write.writeLicense(allocator);
    try write.writeReadme(allocator, project_name);

    print("creating src directory\n", .{});
    try fs.cwd().makeDir("src");
    try std.posix.chdir("src");

    print("writing example code files\n", .{});
    try write.writeFile("main.zig", mainZig);
}
