const std = @import("std");
const mem = std.mem;

pub const RESET = "\x1B[0m";
pub const GREEN = "\x1B[32;1m";
pub const RED = "\x1B[31;1m";
pub const CYAN = "\x1B[36m";

pub const ERR_PREFIX = RED ++ "error" ++ RESET ++ ": ";

pub fn replace(allocator: std.mem.Allocator, string: []const u8, target: []const u8, replacement: []const u8) ![]const u8 {
    const size = mem.replacementSize(u8, string, target, replacement);
    const result = try allocator.alloc(u8, size);
    _ = mem.replace(u8, string, target, replacement, result);
    return result;
}
