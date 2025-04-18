const std = @import("std");
const fs = std.fs;
const mem = std.mem;
const time = @import("time.zig");
const user = @import("user.zig");
const pretty = @import("pretty.zig");

const license = @embedFile("../templates/LICENSE");

pub fn writeLicense(allocator: std.mem.Allocator) !void {
    const year = try time.currentYear();
    const result = try pretty.replace(allocator, license, "{{YEAR}}", year);

    const username = user.getUsername();
    const final = try pretty.replace(allocator, result, "{{USER}}", username);

    try writeFile("LICENSE", final);
}

pub fn writeReadme(allocator: std.mem.Allocator, project_name: []const u8) !void {
    const contents = try pretty.replace(allocator, "# $\n", "$", project_name);
    try writeFile("README.md", contents);
}

pub fn writeFile(fileName: []const u8, contents: []const u8) !void {
    const file = try fs.cwd().createFile(
        fileName,
        .{ .read = true },
    );
    try file.writeAll(contents);
    file.close();
}
