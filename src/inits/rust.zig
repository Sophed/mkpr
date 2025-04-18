const std = @import("std");
const fs = std.fs;
const print = std.debug.print;
const cmd = @import("../util/cmd.zig");
const write = @import("../util/write.zig");
const pretty = @import("../util/pretty.zig");

const justfile = @embedFile("../templates/rust/justfile");
const exampleTestRs = @embedFile("../templates/rust/tests/example_test.rs");

pub fn init(allocator: std.mem.Allocator, project_name: []const u8) void {
    var argv = [_][]const u8{ "cargo", "version" };
    cmd.run(allocator, &argv) catch {
        print(pretty.ERR_PREFIX ++ "Cargo is not installed - please install it to use this template\n", .{});
        std.process.exit(1);
        return;
    };

    print(pretty.GREEN ++ "󰣪 creating Rust project" ++ pretty.RESET ++ ": {s}\n", .{project_name});
    setup(allocator, project_name) catch |err| {
        print(pretty.ERR_PREFIX ++ "{}\n", .{err});
        std.process.exit(1);
        return;
    };
}

fn setup(allocator: std.mem.Allocator, project_name: []const u8) !void {
    print("initializing Rust crate\n", .{});
    var argv = [_][]const u8{ "cargo", "init", project_name };
    try cmd.run(allocator, &argv);
    try std.posix.chdir(project_name);

    print("writing meta files\n", .{});
    try write.writeFile("justfile", justfile);
    try write.writeLicense(allocator);
    try write.writeReadme(allocator, project_name);

    print("creating example tests\n", .{});
    try fs.cwd().makeDir("tests");
    try std.posix.chdir("tests");
    try write.writeFile("example_test.rs", exampleTestRs);
}
