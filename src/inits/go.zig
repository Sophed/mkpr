const std = @import("std");
const fs = std.fs;
const print = std.debug.print;
const cmd = @import("../util/cmd.zig");
const write = @import("../util/write.zig");
const pretty = @import("../util/pretty.zig");

const justfile = @embedFile("../templates/go/justfile");
const gitignore = @embedFile("../templates/go/.gitignore");
const mainGo = @embedFile("../templates/go/app/main.go");
const mainTestGo = @embedFile("../templates/go/app/main_test.go");

pub fn init(allocator: std.mem.Allocator, project_name: []const u8) void {
    var argv = [_][]const u8{ "go", "version" };
    cmd.run(allocator, &argv) catch {
        print(pretty.ERR_PREFIX ++ "Go is not installed - please install it to use this template\n", .{});
        std.process.exit(1);
        return;
    };

    print(pretty.GREEN ++ "󰣪 creating Go project" ++ pretty.RESET ++ ": {s}\n", .{project_name});
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

    print("initializing local Git repository\n", .{});
    try cmd.gitInit(allocator);

    print("initializing Go module\n", .{});
    var argv = [_][]const u8{ "go", "mod", "init", project_name };
    try cmd.run(allocator, &argv);

    print("writing meta files\n", .{});
    try write.writeFile("justfile", justfile);
    try write.writeFile(".gitignore", gitignore);
    try write.writeLicense(allocator);
    try write.writeReadme(allocator, project_name);

    print("creating app directory\n", .{});
    try fs.cwd().makeDir("app");
    try std.posix.chdir("app");

    print("writing example code files\n", .{});
    try write.writeFile("main.go", mainGo);
    try write.writeFile("main_test.go", mainTestGo);
}
