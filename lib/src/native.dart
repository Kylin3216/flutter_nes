// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

class FlutterNesNative {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  FlutterNesNative(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  FlutterNesNative.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  /// Creates a `FlutterNes`
  ffi.Pointer<FlutterNes> create() {
    return _create();
  }

  late final _create_ptr = _lookup<ffi.NativeFunction<_c_create>>('create');
  late final _dart_create _create = _create_ptr.asFunction<_dart_create>();

  void destory(
    ffi.Pointer<FlutterNes> fnes,
  ) {
    return _destory(
      fnes,
    );
  }

  late final _destory_ptr = _lookup<ffi.NativeFunction<_c_destory>>('destory');
  late final _dart_destory _destory = _destory_ptr.asFunction<_dart_destory>();

  /// Sets up NES rom
  ///
  /// # Arguments
  /// * `rom` Rom image binary `Uint8Array`
  void set_rom(
    ffi.Pointer<FlutterNes> fnes,
    ffi.Pointer<RomBuffer> contents,
  ) {
    return _set_rom(
      fnes,
      contents,
    );
  }

  late final _set_rom_ptr = _lookup<ffi.NativeFunction<_c_set_rom>>('set_rom');
  late final _dart_set_rom _set_rom = _set_rom_ptr.asFunction<_dart_set_rom>();

  /// Boots up
  void bootup(
    ffi.Pointer<FlutterNes> fnes,
  ) {
    return _bootup(
      fnes,
    );
  }

  late final _bootup_ptr = _lookup<ffi.NativeFunction<_c_bootup>>('bootup');
  late final _dart_bootup _bootup = _bootup_ptr.asFunction<_dart_bootup>();

  /// Resets
  void reset(
    ffi.Pointer<FlutterNes> fnes,
  ) {
    return _reset(
      fnes,
    );
  }

  late final _reset_ptr = _lookup<ffi.NativeFunction<_c_reset>>('reset');
  late final _dart_reset _reset = _reset_ptr.asFunction<_dart_reset>();

  /// Executes a CPU cycle
  void step(
    ffi.Pointer<FlutterNes> fnes,
  ) {
    return _step(
      fnes,
    );
  }

  late final _step_ptr = _lookup<ffi.NativeFunction<_c_step>>('step');
  late final _dart_step _step = _step_ptr.asFunction<_dart_step>();

  /// Executes a PPU (screen refresh) frame
  void step_frame(
    ffi.Pointer<FlutterNes> fnes,
  ) {
    return _step_frame(
      fnes,
    );
  }

  late final _step_frame_ptr =
      _lookup<ffi.NativeFunction<_c_step_frame>>('step_frame');
  late final _dart_step_frame _step_frame =
      _step_frame_ptr.asFunction<_dart_step_frame>();

  /// Copies RGB pixels of screen to passed RGBA pixels.
  /// The RGBA pixels length should be
  /// 245760 = 256(width) * 240(height) * 4(RGBA).
  /// A channel will be filled with 255(opaque).
  ///
  /// # Arguments
  /// * `pixels` RGBA pixels `Uint8Array` or `Uint8ClampedArray`
  ffi.Pointer<ffi.Uint8> get_pixels(
    ffi.Pointer<FlutterNes> fnes,
  ) {
    return _get_pixels(
      fnes,
    );
  }

  late final _get_pixels_ptr =
      _lookup<ffi.NativeFunction<_c_get_pixels>>('get_pixels');
  late final _dart_get_pixels _get_pixels =
      _get_pixels_ptr.asFunction<_dart_get_pixels>();

  /// Copies audio buffer to passed `Float32Array` buffer.
  /// The length should be 4096.
  ///
  /// # Arguments
  /// * `buffer` Audio buffer `Float32Array`
  ffi.Pointer<ffi.Float> get_audio_buffer(
    ffi.Pointer<FlutterNes> fnes,
  ) {
    return _get_audio_buffer(
      fnes,
    );
  }

  late final _get_audio_buffer_ptr =
      _lookup<ffi.NativeFunction<_c_get_audio_buffer>>('get_audio_buffer');
  late final _dart_get_audio_buffer _get_audio_buffer =
      _get_audio_buffer_ptr.asFunction<_dart_get_audio_buffer>();

  /// Presses a pad button
  ///
  /// # Arguments
  /// * `button`
  void press_button(
    ffi.Pointer<FlutterNes> fnes,
    int button,
  ) {
    return _press_button(
      fnes,
      button,
    );
  }

  late final _press_button_ptr =
      _lookup<ffi.NativeFunction<_c_press_button>>('press_button');
  late final _dart_press_button _press_button =
      _press_button_ptr.asFunction<_dart_press_button>();

  /// Releases a pad button
  ///
  /// # Arguments
  /// * `buffer`
  void release_button(
    ffi.Pointer<FlutterNes> fnes,
    int button,
  ) {
    return _release_button(
      fnes,
      button,
    );
  }

  late final _release_button_ptr =
      _lookup<ffi.NativeFunction<_c_release_button>>('release_button');
  late final _dart_release_button _release_button =
      _release_button_ptr.asFunction<_dart_release_button>();
}

class FlutterNes extends ffi.Opaque {}

class RomBuffer extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> data;

  @ffi.Uint64()
  external int length;
}

typedef _c_create = ffi.Pointer<FlutterNes> Function();

typedef _dart_create = ffi.Pointer<FlutterNes> Function();

typedef _c_destory = ffi.Void Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _dart_destory = void Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _c_set_rom = ffi.Void Function(
  ffi.Pointer<FlutterNes> fnes,
  ffi.Pointer<RomBuffer> contents,
);

typedef _dart_set_rom = void Function(
  ffi.Pointer<FlutterNes> fnes,
  ffi.Pointer<RomBuffer> contents,
);

typedef _c_bootup = ffi.Void Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _dart_bootup = void Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _c_reset = ffi.Void Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _dart_reset = void Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _c_step = ffi.Void Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _dart_step = void Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _c_step_frame = ffi.Void Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _dart_step_frame = void Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _c_get_pixels = ffi.Pointer<ffi.Uint8> Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _dart_get_pixels = ffi.Pointer<ffi.Uint8> Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _c_get_audio_buffer = ffi.Pointer<ffi.Float> Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _dart_get_audio_buffer = ffi.Pointer<ffi.Float> Function(
  ffi.Pointer<FlutterNes> fnes,
);

typedef _c_press_button = ffi.Void Function(
  ffi.Pointer<FlutterNes> fnes,
  ffi.Int32 button,
);

typedef _dart_press_button = void Function(
  ffi.Pointer<FlutterNes> fnes,
  int button,
);

typedef _c_release_button = ffi.Void Function(
  ffi.Pointer<FlutterNes> fnes,
  ffi.Int32 button,
);

typedef _dart_release_button = void Function(
  ffi.Pointer<FlutterNes> fnes,
  int button,
);
