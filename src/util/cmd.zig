const std = @import("std");
const fs = std.fs;

const RunError = error{ShellCmdFailed};

pub fn run(allocator: std.mem.Allocator, argv: [][]const u8) !void {
    var child = std.process.Child.init(argv, allocator);
    child.stdout_behavior = .Ignore;
    child.stderr_behavior = .Ignore;
    child.cwd_dir = fs.cwd();

    try child.spawn();
    const term = try child.wait();

    if (term.Exited != 0) {
        return RunError.ShellCmdFailed;
    }
}

pub fn gitInit(allocator: std.mem.Allocator) !void {
    var argv = [_][]const u8{ "git", "init" };
    try run(allocator, &argv);
}
