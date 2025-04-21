const std = @import("std");
const print = std.debug.print;
const testing = std.testing;

pub fn main() !void {
    print("Hello, World!\n", .{});
}

test "example test" {
    const result = 3 + 4;
    try testing.expect(result == 7);
}

test { // reference all tests in the project
    std.testing.refAllDecls(@This());
}
