# Bare metal (no_std) Rust on Arduino Mega 2560 Rev3

Instructions:

- Follow the instructions at https://github.com/chrislattman/test-bare-metal to install `avrdude` and `avr-gcc` if you haven't already
- Run `rustup component add rust-src --toolchain nightly-x86_64-unknown-linux-gnu`
- Run `git submodule update --init --recursive`

Use the provided Makefile to run the example.
