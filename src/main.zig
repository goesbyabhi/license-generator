const std = @import("std");
const http = std.http;
const json = std.json;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var client = http.Client{ .allocator = allocator };
    defer client.deinit();

    const uri = try std.Uri.parse("https://api.github.com/licenses");
    var buf: [4096]u8 = undefined;
    var req = try client.open(.GET, uri, .{ .server_header_buffer = &buf });
    defer req.deinit();

    try req.send();
    try req.wait();
    try req.finish();

    var buffer: [8192]u8 = undefined;
    const res_len = try req.reader().readAll(&buffer);

    const parsed = try json.parseFromSlice(json.Value, allocator, buffer[0..res_len], .{});
    defer parsed.deinit();

    try json.stringify(parsed.value, .{ .whitespace = .indent_4 }, std.io.getStdOut().writer());

    std.debug.print("\n", .{});
}
