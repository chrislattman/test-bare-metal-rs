#![no_std]
#![no_main]

#[cfg(not(debug_assertions))]
use arduino_hal::delay_ms;
use arduino_hal::{Peripherals, default_serial, hal::wdt, pins, prelude::*};
use core::panic::PanicInfo;
use ufmt::uwriteln;

#[arduino_hal::entry]
fn main() -> ! {
    let dp = Peripherals::take().unwrap();
    let pins = pins!(dp);
    let mut serial = default_serial!(dp, pins, 115_200);

    let mut led = pins.d13.into_output().downgrade();
    let mut watchdog = wdt::Wdt::new(dp.WDT, dp.CPU.mcusr());
    watchdog.start(wdt::Timeout::Ms4000).unwrap();

    loop {
        led.set_high();
        #[cfg(not(debug_assertions))]
        delay_ms(1000);
        uwriteln!(&mut serial, "Hello\r").unwrap_infallible();
        led.set_low();
        #[cfg(not(debug_assertions))]
        delay_ms(1000);
        uwriteln!(&mut serial, "World!\r").unwrap_infallible();
        watchdog.feed();
    }
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
