const std = @import("std");
const print = std.debug.print;
const eql = std.mem.eql;
const pretty = @import("util/pretty.zig");
const initGo = @import("inits/go.zig");
const initRust = @import("inits/rust.zig");
const initZig = @import("inits/zig.zig");

const Template = enum { go, zig, rust };

pub fn main() u8 {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const args = std.process.argsAlloc(allocator) catch {
        print(pretty.ERR_PREFIX ++ "failed to get allocator\n", .{});
        return 1;
    };

    if (std.os.argv.len != 3) {
        if (std.os.argv.len == 2 and eql(u8, args[1], "ls")) {
            print(pretty.CYAN ++ "available templates" ++ pretty.RESET ++ ": go, zig, rust\n", .{});
            return 0;
        }
        print(pretty.CYAN ++ "usage" ++ pretty.RESET ++ ": mkpr <template> <project-name>\nuse 'mkpr ls' for a list of templates\n", .{});
        return 1;
    }

    const template_name = args[1];
    const project_name = args[2];

    const template: Template = std.meta.stringToEnum(Template, template_name) orelse {
        print(pretty.ERR_PREFIX ++ "unknown template\n", .{});
        return 1;
    };

    switch (template) {
        .go => {
            initGo.init(allocator, project_name);
        },
        .rust => {
            initRust.init(allocator, project_name);
        },
        .zig => {
            initZig.init(allocator, project_name);
        },
        // else => {
        //     print(pretty.ERR_PREFIX ++ "this template is not fully implemented\n", .{});
        //     return 1;
        // },
    }
    print(pretty.GREEN ++ "󰄬 project created successfully! " ++ pretty.RESET ++ "to get started just" ++ pretty.CYAN ++ " cd " ++ pretty.RESET ++ "in.\n", .{});
    print(pretty.CYAN ++ " " ++ pretty.RESET ++ "use" ++ pretty.CYAN ++ " just run " ++ pretty.RESET ++ "to run your project!\n", .{});

    return 0;
}
