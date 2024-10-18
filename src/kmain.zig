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
    while (true) {}
}
