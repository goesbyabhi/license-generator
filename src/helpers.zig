const std = @import("std");
const stdout = std.io.getStdOut().writer();
const string = []const u8;

const Todo = @This();
/// userId: Takes a userId value of type i32
userId: i32,
/// id: Takes a id value of type i32
id: i32,
/// title: Takes a title value of type []const u8 (currently goes by string)
title: string,
/// completed: Takes a userId value of type bool
completed: bool,

/// Prints the response obtained from the todo list. Make sure to pass the parsed json value
/// from the buffer into the parameters.
pub fn printResponse(response: Todo) !void {
    try stdout.print(
        \\ TODO Item:
        \\ User Id: {d}
        \\ Id: {d}
        \\ Title: "{s}"
        \\ Completed: {}
        \\
    , .{ response.userId, response.id, response.title, response.completed });
}
