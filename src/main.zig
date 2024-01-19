const c = @cImport(@cInclude("add.h"));

pub fn main() void {
    c.add_u32(1, 2);
}
