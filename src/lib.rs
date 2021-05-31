extern crate nes_rust;

use nes_rust::button;
use nes_rust::default_audio::DefaultAudio;
use nes_rust::default_display::DefaultDisplay;
use nes_rust::default_input::DefaultInput;
use nes_rust::rom::Rom;
use nes_rust::Nes;
use std::os::raw::{c_float, c_uchar};
/// get [`FlutterNes`] from FlutterNes pointer.
macro_rules! fnes {
    ($ptr:expr) => {{
        fnes!($ptr, ())
    }};
    ($ptr:expr,$rt:expr) => {{
        if ($ptr as *mut FlutterNes).is_null() {
            return $rt;
        } else {
            let nes = unsafe { &mut *$ptr };
            nes
        }
    }};
}

macro_rules! rom {
    ($ptr:expr) => {{
        unsafe {
            let key = *Box::from_raw($ptr as *mut RomBuffer);
            std::slice::from_raw_parts(key.data, key.length)
        }
    }};
}

fn to_button_internal(button: i32) -> Option<button::Button> {
    match button {
        0 => Some(button::Button::Poweroff),
        1 => Some(button::Button::Reset),
        2 => Some(button::Button::Select),
        3 => Some(button::Button::Start),
        4 => Some(button::Button::Joypad1A),
        5 => Some(button::Button::Joypad1B),
        6 => Some(button::Button::Joypad1Up),
        7 => Some(button::Button::Joypad1Down),
        8 => Some(button::Button::Joypad1Left),
        9 => Some(button::Button::Joypad1Right),
        10 => Some(button::Button::Joypad2A),
        11 => Some(button::Button::Joypad2B),
        12 => Some(button::Button::Joypad2Up),
        13 => Some(button::Button::Joypad2Down),
        14 => Some(button::Button::Joypad2Left),
        15 => Some(button::Button::Joypad2Right),
        _ => None,
    }
}

#[repr(C)]
pub struct RomBuffer {
    data: *const c_uchar,
    length: usize,
}

pub struct FlutterNes {
    nes: Nes,
}

/// Creates a `FlutterNes`
#[no_mangle]
pub extern "C" fn create() -> *mut FlutterNes {
    let input = Box::new(DefaultInput::new());
    let display = Box::new(DefaultDisplay::new());
    let audio = Box::new(DefaultAudio::new());
    let nes = Nes::new(input, display, audio);
    Box::into_raw(Box::new(FlutterNes { nes: nes }))
}

#[no_mangle]
pub extern "C" fn destory(fnes: *mut FlutterNes) {
    if fnes.is_null() {
        return;
    }
    unsafe { Box::from_raw(fnes) };
}

/// Sets up NES rom
///
/// # Arguments
/// * `rom` Rom image binary `Uint8Array`
#[no_mangle]
pub extern "C" fn set_rom(fnes: *mut FlutterNes, contents: *mut RomBuffer) {
    let fnes = fnes!(fnes);
    let rom_contents = rom!(contents);
    fnes.nes.set_rom(Rom::new(rom_contents.to_vec()));
}

/// Boots up
#[no_mangle]
pub extern "C" fn bootup(fnes: *mut FlutterNes) {
    let fnes = fnes!(fnes);
    fnes.nes.bootup();
}

/// Resets
#[no_mangle]
pub extern "C" fn reset(fnes: *mut FlutterNes) {
    let fnes = fnes!(fnes);
    fnes.nes.reset();
}

/// Executes a CPU cycle
#[no_mangle]
pub extern "C" fn step(fnes: *mut FlutterNes) {
    let fnes = fnes!(fnes);
    fnes.nes.step();
}

/// Executes a PPU (screen refresh) frame
#[no_mangle]
pub extern "C" fn step_frame(fnes: *mut FlutterNes) {
    let fnes = fnes!(fnes);
    fnes.nes.step_frame();
}

/// Copies RGB pixels of screen to passed RGBA pixels.
/// The RGBA pixels length should be
/// 245760 = 256(width) * 240(height) * 4(RGBA).
/// A channel will be filled with 255(opaque).
///
/// # Arguments
/// * `pixels` RGBA pixels `Uint8Array` or `Uint8ClampedArray`
#[no_mangle]
pub extern "C" fn get_pixels(fnes: *mut FlutterNes) -> *const c_uchar {
    let mut pixels: [u8; 245760] = [0; 245760];
    let fnes = fnes!(fnes, pixels.as_ptr());
    fnes.nes.copy_pixels(&mut pixels);
    pixels.as_ptr()
}

/// Copies audio buffer to passed `Float32Array` buffer.
/// The length should be 4096.
///
/// # Arguments
/// * `buffer` Audio buffer `Float32Array`
#[no_mangle]
pub extern "C" fn get_audio_buffer(fnes: *mut FlutterNes) -> *const c_float {
    let mut buffer: [f32; 4096] = [0.0; 4096];
    let fnes = fnes!(fnes, buffer.as_ptr());
    fnes.nes.copy_sample_buffer(&mut buffer);
    buffer.as_ptr()
}

/// Presses a pad button
///
/// # Arguments
/// * `button`
#[no_mangle]
pub extern "C" fn press_button(fnes: *mut FlutterNes, button: i32) {
    let fnes = fnes!(fnes);
    if let Some(button) = to_button_internal(button) {
        fnes.nes.press_button(button);
    }
}

/// Releases a pad button
///
/// # Arguments
/// * `buffer`
#[no_mangle]
pub extern "C" fn release_button(fnes: *mut FlutterNes, button: i32) {
    let fnes = fnes!(fnes);
    if let Some(button) = to_button_internal(button) {
        fnes.nes.release_button(button);
    }
}

#[cfg(test)]
mod tests {}
