const std = @import("std");

pub fn currentYear() ![]const u8 {
    // var epoch_seconds = std.time.epoch.EpochSeconds{
    //     .secs = @intCast(std.time.timestamp()),
    // };
    // const year = epoch_seconds.getEpochDay().calculateYearDay().year;
    // var buf: [4]u8 = undefined;
    // const str = try std.fmt.bufPrint(&buf, "{d}", .{year});
    // TODO: figure out why this isn't formatting right

    const str = "2025";
    return str;
}
