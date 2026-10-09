default:
	cargo +nightly build --release
	# avr-objcopy -O ihex -R .eeprom ./target/avr-none/release/test-bare-metal-rs.elf test-bare-metal-rs.hex # -j .text -j .data

test:
	cargo +nightly build

deploy:
	cargo +nightly run --release

deploy_qemu: default
	qemu-system-avr -machine mega2560 -bios ./target/avr-none/release/test-bare-metal-rs.elf -nographic -serial telnet:localhost:5678,server=on,wait=off
	# In another shell: telnet localhost 5678
	# Quit qemu: (qemu) quit
	# Quit telnet: Ctrl + ] -> telnet> quit

test_qemu: test
	qemu-system-avr -machine mega2560 -bios ./target/avr-none/debug/test-bare-metal-rs.elf -nographic -serial telnet:localhost:5678,server=on,wait=off -S -s
	# To specify a different GDB port, replace -s with -gdb tcp:localhost:<PORT>
	# In another shell (replace gdb-multiarch with avr-gdb if using macOS):
	# RUST_GDB=gdb-multiarch rust-gdb -q ./target/avr-none/debug/test-bare-metal-rs.elf
	# (gdb) target remote localhost:1234
	# (gdb) break main
	# (gdb) continue
	# (gdb) step
	# In another shell: telnet localhost 5678

clean:
	cargo clean
