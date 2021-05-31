import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nes/src/native.dart';

///
/// Created by iceKylin on 2021/5/28
///
final FlutterNesNative _native = FlutterNesNative(_loadLibrary());

DynamicLibrary _loadLibrary() {
  return Platform.isAndroid ? DynamicLibrary.open("libfnes.so") : DynamicLibrary.process();
}

void _handler(SendPort sendPort) {
  final port = ReceivePort();
  final pointer = _native.create();
  port.listen((message) {
    var pm = message as PortMessage;
    switch (pm.method) {
      case "setRom":
        _native.set_rom(pointer, _createBuffer(pm.data));
        pm.sendPort.send(true);
        break;
      case "bootup":
        _native.bootup(pointer);
        pm.sendPort.send(true);
        break;
      case "reset":
        _native.reset(pointer);
        pm.sendPort.send(true);
        break;
      case "step":
        _native.step(pointer);
        pm.sendPort.send(true);
        break;
      case "stepFrame":
        _native.step_frame(pointer);
        pm.sendPort.send(true);
        break;
      case "getPixels":
        var data = _native.get_pixels(pointer);
        pm.sendPort.send(data.asTypedList(245760));
        break;
      case "getAudioBuffer":
        var data = _native.get_audio_buffer(pointer);
        pm.sendPort.send(data.asTypedList(4096));
        break;
      case "pressButton":
        _native.press_button(pointer, pm.data);
        pm.sendPort.send(true);
        break;
      case "releaseButton":
        _native.release_button(pointer, pm.data);
        pm.sendPort.send(true);
        break;
      case "dispose":
        _native.destory(pointer);
        pm.sendPort.send(true);
        break;
      default:
        break;
    }
  });
  sendPort.send(port.sendPort);
}

class PortMessage {
  String method;
  dynamic data;
  SendPort sendPort;

  PortMessage(this.method, this.sendPort, {this.data});
}

class FNesAsync {
  Isolate _isolate;
  SendPort _sendPort;

  FNesAsync._(this._isolate, this._sendPort);

  static Future<FNesAsync> create() async {
    ReceivePort receivePort = ReceivePort();
    var isolate = await Isolate.spawn(_handler, receivePort.sendPort);
    var port = await receivePort.first as SendPort;
    var fnes = FNesAsync._(isolate, port);
    return fnes;
  }

  Future<void> setRom(NesRom rom) async {
    try {
      var buffer = await rom._buffer;
      await _portCall("setRom", data: buffer);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> _portCall(String method, {dynamic data}) async {
    var port = ReceivePort();
    _sendPort.send(PortMessage(method, port.sendPort, data: data));
    return port.first;
  }

  Future<dynamic> bootup() => _portCall("bootup");

  Future<dynamic> reset() => _portCall("reset");

  Future<dynamic> step() => _portCall("step");

  Future<dynamic> stepFrame() => _portCall("stepFrame");

  Future<Uint8List> getPixels() async {
    var data = await _portCall("getPixels") as Uint8List;
    return data;
  }

  Future<Float32List> getAudioBuffer() async {
    return await _portCall("getAudioBuffer") as Float32List;
  }

  Future<dynamic> pressButton(NesButton button) => _portCall("pressButton", data: button.index);

  Future<dynamic> releaseButton(NesButton button) => _portCall("releaseButton", data: button.index);

  Future<void> dispose() async {
    await _portCall("dispose");
    _isolate.kill(priority: Isolate.immediate);
  }
}

class FNes {
  Pointer<FlutterNes> _nes;

  FNes._(this._nes);

  factory FNes.create() => FNes._(_native.create());

  Future<void> setRom(NesRom rom) async {
    try {
      var buffer = await rom._buffer;
      _native.set_rom(_nes, _createBuffer(buffer));
    } catch (e) {
      print(e);
    }
  }

  void bootup() => _native.bootup(_nes);

  void reset() => _native.reset(_nes);

  void step() => _native.step(_nes);

  void stepFrame() => _native.step_frame(_nes);

  Uint8List getPixels() {
    var pixels = _native.get_pixels(_nes);
    return pixels.asTypedList(245760);
  }

  Float32List getAudioBuffer() {
    var buffer = _native.get_audio_buffer(_nes);
    return buffer.asTypedList(4096);
  }

  void pressButton(NesButton button) => _native.press_button(_nes, button.index);

  void releaseButton(NesButton button) => _native.release_button(_nes, button.index);

  void dispose() => _native.destory(_nes);
}

/// button map
enum NesButton {
  Poweroff,
  Reset,
  Select,
  Start,
  Joypad1A,
  Joypad1B,
  Joypad1Up,
  Joypad1Down,
  Joypad1Left,
  Joypad1Right,
  Joypad2A,
  Joypad2B,
  Joypad2Up,
  Joypad2Down,
  Joypad2Left,
  Joypad2Right,
}

class NesRom {
  String path;
  bool network;

  NesRom.asset(this.path) : network = false;

  NesRom.network(this.path) : network = true;

  Future<Uint8List> get _buffer async {
    Uint8List data;
    if (network) {
      var uri = Uri.parse(path);
      data = await http.readBytes(uri);
    } else {
      var bd = await rootBundle.load(path);
      data = bd.buffer.asUint8List();
    }
    return data;
  }
}

Pointer<RomBuffer> _createBuffer(Uint8List data) {
  Pointer<Uint8> p = calloc.allocate(data.length);
  for (var i = 0, len = data.length; i < len; ++i) {
    p[i] = data[i];
  }
  final dd = calloc.allocate<RomBuffer>(data.length + 4);
  dd.ref.data = p;
  dd.ref.length = data.length;
  return dd;
}
