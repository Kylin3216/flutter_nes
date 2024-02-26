#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct WireSyncReturnStruct {
  uint8_t *ptr;
  int32_t len;
  bool success;
} WireSyncReturnStruct;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

void wire_nes_create(int64_t port_);

void wire_nes_destroy(int64_t port_, uintptr_t pointer);

void wire_nes_prepare(int64_t port_, uintptr_t pointer, struct wire_uint_8_list *rom_data);

void wire_nes_next_frame(int64_t port_, uintptr_t pointer);

void wire_nes_reset(int64_t port_, uintptr_t pointer);

void wire_nes_press_button(int64_t port_, uintptr_t pointer, int32_t button);

void wire_nes_release_button(int64_t port_, uintptr_t pointer, int32_t button);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturnStruct(struct WireSyncReturnStruct val);

void store_dart_post_cobject(DartPostCObjectFnType ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_nes_create);
    dummy_var ^= ((int64_t) (void*) wire_nes_destroy);
    dummy_var ^= ((int64_t) (void*) wire_nes_prepare);
    dummy_var ^= ((int64_t) (void*) wire_nes_next_frame);
    dummy_var ^= ((int64_t) (void*) wire_nes_reset);
    dummy_var ^= ((int64_t) (void*) wire_nes_press_button);
    dummy_var ^= ((int64_t) (void*) wire_nes_release_button);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturnStruct);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}