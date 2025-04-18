const std = @import("std");

pub fn getUsername() []const u8 {
    const name = std.posix.getenv("USER") orelse {
        return "unknown";
    };
    return name;
}
