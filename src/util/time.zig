const std = @import("std");

pub fn currentYear(allocator: std.mem.Allocator) ![]const u8 {
    var epoch_seconds = std.time.epoch.EpochSeconds{
        .secs = @intCast(std.time.timestamp()),
    };
    const year: u16 = epoch_seconds.getEpochDay().calculateYearDay().year;

    var buf: [4]u8 = undefined;
    const fmt = try std.fmt.bufPrint(&buf, "{d}", .{year});

    const str = try allocator.dupe(u8, fmt);
    return str;
}
