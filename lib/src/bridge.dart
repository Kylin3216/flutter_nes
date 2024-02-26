// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`.

// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports

import 'dart:convert';
import 'dart:typed_data';

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'dart:ffi' as ffi;

abstract class Fnes {
  /// create nes simulator
  Future<int> nesCreate({dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNesCreateConstMeta;

  /// destroy nes simulator
  Future<void> nesDestroy({required int pointer, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNesDestroyConstMeta;

  /// prepare nes simulator
  /// set rom and boot up
  Future<void> nesPrepare(
      {required int pointer, required Uint8List romData, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNesPrepareConstMeta;

  /// nes simulator next frame data
  /// Copies RGB pixels of screen to passed RGBA pixels.
  /// The RGBA pixels length should be
  /// 245760 = 256(width) * 240(height) * 4(RGBA).
  /// A channel will be filled with 255(opaque).
  Future<Uint8List> nesNextFrame({required int pointer, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNesNextFrameConstMeta;

  /// reset nes simulator
  Future<void> nesReset({required int pointer, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNesResetConstMeta;

  /// press button
  Future<void> nesPressButton(
      {required int pointer, required NesButton button, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNesPressButtonConstMeta;

  /// release button
  Future<void> nesReleaseButton(
      {required int pointer, required NesButton button, dynamic hint});

  FlutterRustBridgeTaskConstMeta get kNesReleaseButtonConstMeta;
}

enum NesButton {
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

class FnesImpl extends FlutterRustBridgeBase<FnesWire> implements Fnes {
  factory FnesImpl(ffi.DynamicLibrary dylib) => FnesImpl.raw(FnesWire(dylib));

  FnesImpl.raw(FnesWire inner) : super(inner);

  Future<int> nesCreate({dynamic hint}) => executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_nes_create(port_),
        parseSuccessData: _wire2api_usize,
        constMeta: kNesCreateConstMeta,
        argValues: [],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kNesCreateConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "nes_create",
        argNames: [],
      );

  Future<void> nesDestroy({required int pointer, dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) =>
            inner.wire_nes_destroy(port_, _api2wire_usize(pointer)),
        parseSuccessData: _wire2api_unit,
        constMeta: kNesDestroyConstMeta,
        argValues: [pointer],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kNesDestroyConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "nes_destroy",
        argNames: ["pointer"],
      );

  Future<void> nesPrepare(
          {required int pointer, required Uint8List romData, dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_nes_prepare(
            port_,
            _api2wire_usize(pointer),
            _api2wire_ZeroCopyBuffer_Uint8List(romData)),
        parseSuccessData: _wire2api_unit,
        constMeta: kNesPrepareConstMeta,
        argValues: [pointer, romData],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kNesPrepareConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "nes_prepare",
        argNames: ["pointer", "romData"],
      );

  Future<Uint8List> nesNextFrame({required int pointer, dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) =>
            inner.wire_nes_next_frame(port_, _api2wire_usize(pointer)),
        parseSuccessData: _wire2api_ZeroCopyBuffer_Uint8List,
        constMeta: kNesNextFrameConstMeta,
        argValues: [pointer],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kNesNextFrameConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "nes_next_frame",
        argNames: ["pointer"],
      );

  Future<void> nesReset({required int pointer, dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) =>
            inner.wire_nes_reset(port_, _api2wire_usize(pointer)),
        parseSuccessData: _wire2api_unit,
        constMeta: kNesResetConstMeta,
        argValues: [pointer],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kNesResetConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "nes_reset",
        argNames: ["pointer"],
      );

  Future<void> nesPressButton(
          {required int pointer, required NesButton button, dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_nes_press_button(
            port_, _api2wire_usize(pointer), _api2wire_nes_button(button)),
        parseSuccessData: _wire2api_unit,
        constMeta: kNesPressButtonConstMeta,
        argValues: [pointer, button],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kNesPressButtonConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "nes_press_button",
        argNames: ["pointer", "button"],
      );

  Future<void> nesReleaseButton(
          {required int pointer, required NesButton button, dynamic hint}) =>
      executeNormal(FlutterRustBridgeTask(
        callFfi: (port_) => inner.wire_nes_release_button(
            port_, _api2wire_usize(pointer), _api2wire_nes_button(button)),
        parseSuccessData: _wire2api_unit,
        constMeta: kNesReleaseButtonConstMeta,
        argValues: [pointer, button],
        hint: hint,
      ));

  FlutterRustBridgeTaskConstMeta get kNesReleaseButtonConstMeta =>
      const FlutterRustBridgeTaskConstMeta(
        debugName: "nes_release_button",
        argNames: ["pointer", "button"],
      );

  // Section: api2wire
  ffi.Pointer<wire_uint_8_list> _api2wire_ZeroCopyBuffer_Uint8List(
      Uint8List raw) {
    return _api2wire_uint_8_list(raw);
  }

  int _api2wire_i32(int raw) {
    return raw;
  }

  int _api2wire_nes_button(NesButton raw) {
    return _api2wire_i32(raw.index);
  }

  int _api2wire_u8(int raw) {
    return raw;
  }

  ffi.Pointer<wire_uint_8_list> _api2wire_uint_8_list(Uint8List raw) {
    final ans = inner.new_uint_8_list_0(raw.length);
    ans.ref.ptr.asTypedList(raw.length).setAll(0, raw);
    return ans;
  }

  int _api2wire_usize(int raw) {
    return raw;
  }

  // Section: api_fill_to_wire

}

// Section: wire2api
Uint8List _wire2api_ZeroCopyBuffer_Uint8List(dynamic raw) {
  return raw as Uint8List;
}

int _wire2api_u8(dynamic raw) {
  return raw as int;
}

Uint8List _wire2api_uint_8_list(dynamic raw) {
  return raw as Uint8List;
}

void _wire2api_unit(dynamic raw) {
  return;
}

int _wire2api_usize(dynamic raw) {
  return raw as int;
}

// ignore_for_file: camel_case_types, non_constant_identifier_names, avoid_positional_boolean_parameters, annotate_overrides, constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.

/// generated by flutter_rust_bridge
class FnesWire implements FlutterRustBridgeWireBase {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  FnesWire(ffi.DynamicLibrary dynamicLibrary) : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  FnesWire.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  void wire_nes_create(
    int port_,
  ) {
    return _wire_nes_create(
      port_,
    );
  }

  late final _wire_nes_createPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64)>>(
          'wire_nes_create');
  late final _wire_nes_create =
      _wire_nes_createPtr.asFunction<void Function(int)>();

  void wire_nes_destroy(
    int port_,
    int pointer,
  ) {
    return _wire_nes_destroy(
      port_,
      pointer,
    );
  }

  late final _wire_nes_destroyPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64, uintptr_t)>>(
          'wire_nes_destroy');
  late final _wire_nes_destroy =
      _wire_nes_destroyPtr.asFunction<void Function(int, int)>();

  void wire_nes_prepare(
    int port_,
    int pointer,
    ffi.Pointer<wire_uint_8_list> rom_data,
  ) {
    return _wire_nes_prepare(
      port_,
      pointer,
      rom_data,
    );
  }

  late final _wire_nes_preparePtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(ffi.Int64, uintptr_t,
              ffi.Pointer<wire_uint_8_list>)>>('wire_nes_prepare');
  late final _wire_nes_prepare = _wire_nes_preparePtr
      .asFunction<void Function(int, int, ffi.Pointer<wire_uint_8_list>)>();

  void wire_nes_next_frame(
    int port_,
    int pointer,
  ) {
    return _wire_nes_next_frame(
      port_,
      pointer,
    );
  }

  late final _wire_nes_next_framePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64, uintptr_t)>>(
          'wire_nes_next_frame');
  late final _wire_nes_next_frame =
      _wire_nes_next_framePtr.asFunction<void Function(int, int)>();

  void wire_nes_reset(
    int port_,
    int pointer,
  ) {
    return _wire_nes_reset(
      port_,
      pointer,
    );
  }

  late final _wire_nes_resetPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Int64, uintptr_t)>>(
          'wire_nes_reset');
  late final _wire_nes_reset =
      _wire_nes_resetPtr.asFunction<void Function(int, int)>();

  void wire_nes_press_button(
    int port_,
    int pointer,
    int button,
  ) {
    return _wire_nes_press_button(
      port_,
      pointer,
      button,
    );
  }

  late final _wire_nes_press_buttonPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64, uintptr_t, ffi.Int32)>>('wire_nes_press_button');
  late final _wire_nes_press_button =
      _wire_nes_press_buttonPtr.asFunction<void Function(int, int, int)>();

  void wire_nes_release_button(
    int port_,
    int pointer,
    int button,
  ) {
    return _wire_nes_release_button(
      port_,
      pointer,
      button,
    );
  }

  late final _wire_nes_release_buttonPtr = _lookup<
      ffi.NativeFunction<
          ffi.Void Function(
              ffi.Int64, uintptr_t, ffi.Int32)>>('wire_nes_release_button');
  late final _wire_nes_release_button =
      _wire_nes_release_buttonPtr.asFunction<void Function(int, int, int)>();

  ffi.Pointer<wire_uint_8_list> new_uint_8_list_0(
    int len,
  ) {
    return _new_uint_8_list_0(
      len,
    );
  }

  late final _new_uint_8_list_0Ptr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<wire_uint_8_list> Function(
              ffi.Int32)>>('new_uint_8_list_0');
  late final _new_uint_8_list_0 = _new_uint_8_list_0Ptr
      .asFunction<ffi.Pointer<wire_uint_8_list> Function(int)>();

  void free_WireSyncReturnStruct(
    WireSyncReturnStruct val,
  ) {
    return _free_WireSyncReturnStruct(
      val,
    );
  }

  late final _free_WireSyncReturnStructPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(WireSyncReturnStruct)>>(
          'free_WireSyncReturnStruct');
  late final _free_WireSyncReturnStruct = _free_WireSyncReturnStructPtr
      .asFunction<void Function(WireSyncReturnStruct)>();

  void store_dart_post_cobject(
    DartPostCObjectFnType ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }

  late final _store_dart_post_cobjectPtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(DartPostCObjectFnType)>>(
          'store_dart_post_cobject');
  late final _store_dart_post_cobject = _store_dart_post_cobjectPtr
      .asFunction<void Function(DartPostCObjectFnType)>();
}

class wire_uint_8_list extends ffi.Struct {
  external ffi.Pointer<ffi.Uint8> ptr;

  @ffi.Int32()
  external int len;
}

typedef uintptr_t = ffi.UnsignedLong;
typedef DartPostCObjectFnType = ffi.Pointer<
    ffi.NativeFunction<ffi.Bool Function(DartPort, ffi.Pointer<ffi.Void>)>>;
typedef DartPort = ffi.Int64;