#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct FlutterNes FlutterNes;

typedef struct RomBuffer {
  const unsigned char *data;
  uintptr_t length;
} RomBuffer;

/**
 * Creates a `FlutterNes`
 */
struct FlutterNes *create(void);

void destory(struct FlutterNes *fnes);

/**
 * Sets up NES rom
 *
 * # Arguments
 * * `rom` Rom image binary `Uint8Array`
 */
void set_rom(struct FlutterNes *fnes, struct RomBuffer *contents);

/**
 * Boots up
 */
void bootup(struct FlutterNes *fnes);

/**
 * Resets
 */
void reset(struct FlutterNes *fnes);

/**
 * Executes a CPU cycle
 */
void step(struct FlutterNes *fnes);

/**
 * Executes a PPU (screen refresh) frame
 */
void step_frame(struct FlutterNes *fnes);

/**
 * Copies RGB pixels of screen to passed RGBA pixels.
 * The RGBA pixels length should be
 * 245760 = 256(width) * 240(height) * 4(RGBA).
 * A channel will be filled with 255(opaque).
 *
 * # Arguments
 * * `pixels` RGBA pixels `Uint8Array` or `Uint8ClampedArray`
 */
const unsigned char *get_pixels(struct FlutterNes *fnes);

/**
 * Copies audio buffer to passed `Float32Array` buffer.
 * The length should be 4096.
 *
 * # Arguments
 * * `buffer` Audio buffer `Float32Array`
 */
const float *get_audio_buffer(struct FlutterNes *fnes);

/**
 * Presses a pad button
 *
 * # Arguments
 * * `button`
 */
void press_button(struct FlutterNes *fnes, int32_t button);

/**
 * Releases a pad button
 *
 * # Arguments
 * * `buffer`
 */
void release_button(struct FlutterNes *fnes, int32_t button);
