use std::io::Cursor;
use std::mem;
use std::sync::Arc;
use std::sync::atomic::{AtomicBool, Ordering};
use std::thread::sleep;
use std::time::Duration;
use flutter_rust_bridge::{StreamSink, ZeroCopyBuffer};
use nes_rust::{
    default_input::DefaultInput,
    default_display::DefaultDisplay,
    default_audio::DefaultAudio, Nes,
    rom::Rom,
    button::Button,
};

macro_rules! nes_wrapper {
    ($ptr:expr) => {{
        nes_wrapper!($ptr, ())
    }};
    ($ptr:expr,$rt:expr) => {{
        let nes =$ptr as *mut Nes;
        if nes.is_null() {
            return $rt;
        } else {
            let nes = unsafe { &mut *nes };
            nes
        }
    }};
}

/// create nes simulator
pub fn nes_create() -> anyhow::Result<usize> {
    let input = Box::new(DefaultInput::new());
    let display = Box::new(DefaultDisplay::new());
    let audio = Box::new(DefaultAudio::new());
    let nes = Nes::new(input, display, audio);
    Ok(Box::into_raw(Box::new(nes)) as usize)
}

/// destroy nes simulator
pub fn nes_destroy(pointer: usize) {
    let nes = pointer as *mut Nes;
    println!("try destroy nes simulator!!!!{}", pointer);
    if !nes.is_null() {
        println!("nes simulator {} destroyed", pointer);
        unsafe { Box::from_raw(nes) };
    }
}

/// prepare nes simulator
/// set rom and boot up
pub fn nes_prepare(pointer: usize, rom_data: ZeroCopyBuffer<Vec<u8>>) {
    let nes = nes_wrapper!(pointer);
    nes.set_rom(Rom::new(rom_data.0));
    nes.bootup();
}

/// nes simulator next frame data
/// Copies RGB pixels of screen to passed RGBA pixels.
/// The RGBA pixels length should be
/// 245760 = 256(width) * 240(height) * 4(RGBA).
/// A channel will be filled with 255(opaque).
pub fn nes_next_frame(pointer: usize) -> anyhow::Result<ZeroCopyBuffer<Vec<u8>>> {
    let nes = nes_wrapper!(pointer,Err(anyhow::Error::msg("pointer is null")));
    nes.step_frame();
    let mut pixels: [u8; 245760] = [0; 245760];
    nes.copy_pixels(&mut pixels);
    let mut sample: [f32; 4096] = [0f32; 4096];
    nes.copy_sample_buffer(&mut sample);
    println!("{:?}",sample);
    Ok(ZeroCopyBuffer(pixels.to_vec()))
}

/// Copies audio buffer to passed `Float32Array` buffer.
/// The length should be 4096.
// pub fn nes_copy_audio(pointer: usize) -> anyhow::Result<ZeroCopyBuffer<Vec<f32>>> {
//     let nes = nes_wrapper!(pointer,Err(anyhow::Error::msg("pointer is null")));
//
//     Ok(ZeroCopyBuffer(sample.to_vec()))
// }

fn transform_f32_to_u8(v: Vec<f32>) -> Vec<u8> {
    let data = v.as_ptr();
    let element_size = mem::size_of::<f32>();
    let len = v.len() * element_size;
    let capacity = v.capacity() * element_size;
    unsafe {
        // Don't allow the current vector to be dropped
        // (which would invalidate the memory)
        mem::forget(v);
        Vec::from_raw_parts(
            data as *mut u8,
            len,
            capacity,
        )
    }
}

/// reset nes simulator
pub fn nes_reset(pointer: usize) {
    let nes = nes_wrapper!(pointer);
    nes.reset();
}

/// press button
pub fn nes_press_button(pointer: usize, button: NesButton) {
    let nes = nes_wrapper!(pointer);
    nes.press_button(button.transform());
}

/// release button
pub fn nes_release_button(pointer: usize, button: NesButton) {
    let nes = nes_wrapper!(pointer);
    nes.release_button(button.transform());
}


#[repr(C)]
pub enum NesButton {
    PowerOff,
    Reset,
    Select,
    Start,
    JoyPad1A,
    JoyPad1B,
    JoyPad1Up,
    JoyPad1Down,
    JoyPad1Left,
    JoyPad1Right,
    JoyPad2A,
    JoyPad2B,
    JoyPad2Up,
    JoyPad2Down,
    JoyPad2Left,
    JoyPad2Right,
}

impl NesButton {
    fn transform(self) -> Button {
        match self {
            NesButton::PowerOff => Button::Poweroff,
            NesButton::Reset => Button::Reset,
            NesButton::Select => Button::Select,
            NesButton::Start => Button::Start,
            NesButton::JoyPad1A => Button::Joypad1A,
            NesButton::JoyPad1B => Button::Joypad1B,
            NesButton::JoyPad1Up => Button::Joypad1Up,
            NesButton::JoyPad1Down => Button::Joypad1Down,
            NesButton::JoyPad1Left => Button::Joypad1Left,
            NesButton::JoyPad1Right => Button::Joypad1Right,
            NesButton::JoyPad2A => Button::Joypad2A,
            NesButton::JoyPad2B => Button::Joypad2B,
            NesButton::JoyPad2Up => Button::Joypad2Up,
            NesButton::JoyPad2Down => Button::Joypad2Down,
            NesButton::JoyPad2Left => Button::Joypad2Left,
            NesButton::JoyPad2Right => Button::Joypad2Right,
        }
    }
}


#[cfg(test)]
mod tests {
    use crate::api::transform_f32_to_u8;

    #[test]
    fn test() {
        let fv = vec![1f32; 2];
        let uv = transform_f32_to_u8(fv);
        assert_eq!(uv, vec![0, 0, 128, 63, 0, 0, 128, 63]);
    }
}