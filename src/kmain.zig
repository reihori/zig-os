const MAGIC = 0x1BADB002;
const ALIGN = 1 << 0;
const MEMINFO = 1 << 1;
const FLAGS = ALIGN | MEMINFO;

const MultibootHeader = packed struct {
    magic: i32 = MAGIC,
    flags: i32,
    checksum: i32,
    padding: u32 = 0,
};

export const multiboot align(4) linksection(".multiboot") = MultibootHeader{
    .flags = FLAGS,
    .checksum = -(MAGIC + FLAGS),
};

export fn _start() noreturn {
    kmain();
}

fn kmain() noreturn {
    vgaWriteString("Hello, World!", 0, 0, .lightred);
    while (true) {}
}

const VgaColor = enum(u8) {
    black = 0,
    blue = 1,
    green = 2,
    cyan = 3,
    red = 4,
    magenta = 5,
    brown = 6,
    lightgrey = 7,
    darkgrey = 8,
    lightblue = 9,
    lightgreen = 10,
    lightcyan = 11,
    lightred = 12,
    lightmagenta = 13,
    yellow = 14,
    white = 15,
};

fn vgaWriteChar(char: u8, x: usize, y: usize, color: VgaColor) void {
    const vgaBuffer: [*]volatile u16 = @ptrFromInt(0xB8000);
    vgaBuffer[y * 80 + x] = @as(u16, @intFromEnum(color)) << 8 | @as(u16, char);
}

fn vgaWriteString(string: []const u8, x: usize, y: usize, color: VgaColor) void {
    for (string, 0..) |char, i| {
        vgaWriteChar(char, x + i, y, color);
    }
}
