# Bare metal (no_std) Rust on Arduino Mega 2560 Rev3

Instructions:

- Follow the instructions at https://github.com/chrislattman/test-bare-metal to install `avrdude` and `avr-gcc` if you haven't already
- Run `rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu`
- Run `git submodule update --init --recursive`

The rust-toolchain.toml implicitly adds +nightly to all the relevant `cargo` commands. To run the example:

- `cargo build --release`: build the firmware (`cargo build` for a debug build)
- `cargo run --release`: build and flash it to the board with `avrdude` on `/dev/ttyACM0`, or pick the port with `DEV=<device> cargo run --release`
- `cargo qemu`: run the release build in `qemu-system-avr`, with serial output on `telnet localhost 5678`
- `cargo qemu-debug`: run the debug build in QEMU, halted and waiting for GDB on `localhost:1234`

See the comments in `.cargo/config.toml` for how to connect to QEMU and GDB.
