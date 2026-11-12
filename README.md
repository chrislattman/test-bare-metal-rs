# Bare metal (no_std) Rust on Arduino Mega 2560 Rev3

Instructions:

- Follow the instructions at https://github.com/chrislattman/test-bare-metal to install `avrdude` and `avr-gcc` if you haven't already
- Run `git submodule update --init --recursive`

To run the example:

- `cargo build --release`: build the firmware (`cargo build` for a debug build)
- `cargo run --release`: build and flash it to the board with `avrdude` on `/dev/ttyACM0`, or pick the port with `DEV=<device> cargo run --release`
- `cargo qemu`: run the release build in `qemu-system-avr`, with serial output on `telnet localhost 5678`
- `cargo qemu-debug`: run the debug build in QEMU, halted and waiting for GDB on `localhost:1234`

See the comments in `.cargo/config.toml` for how to connect to QEMU and GDB.

The `Rust: Remote Attach` configuration in `.vscode/launch.json` uses the Microsoft C/C++ extension (`type: cppdbg`) to attach to `cargo qemu-debug` on `localhost:1234`. It runs `gdb-multiarch` directly rather than `rust-gdb`: `rust-gdb` only adds Rust's pretty-printers, which GDB loads through a `.debug_gdb_scripts` section that bare-metal Rust binaries don't have, and GDB already understands Rust code on its own. Set breakpoints by line (e.g. `main.rs:12`), since `#[arduino_hal::entry]` renames `main`.
