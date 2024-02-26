import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';

import 'dart:ui' as ui;

import 'bridge.dart';

///
/// Created by iceKylin on 2021/5/28
///
final Fnes _native = FnesImpl(_loadLibrary());

DynamicLibrary _loadLibrary() {
  return Platform.isAndroid ? DynamicLibrary.open("libfnes.so") : DynamicLibrary.process();
}

class FlutterNesRom {
  String path;
  bool network;

  FlutterNesRom.asset(this.path) : network = false;

  FlutterNesRom.network(this.path) : network = true;

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

/// 245760 = 256(width) * 240(height) * 4(RGBA).
const kFrameLength = 256 * 240 * 4;

class FlutterNes {
  int _nesPointer = 0;

  int get nesPointer {
    if (_nesPointer == 0) throw "FlutterNes is not init or already destroyed!!";
    return _nesPointer;
  }

  bool _isStarting = false;

  FlutterNes._(this._nesPointer);

  FlutterSoundPlayer? player;

  Stream<ui.Image> get frameStream => _frameStreamController.stream;

  final StreamController<ui.Image> _frameStreamController = StreamController();

  /// create flutter nes
  static Future<FlutterNes> create() async {
    final pointer = await _native.nesCreate();
    return FlutterNes._(pointer);
  }

  Future<void> start(FlutterNesRom rom) async {
    if (_isStarting) throw "FlutterNes already started!!";
    _isStarting = true;
    await _native.nesPrepare(pointer: nesPointer, romData: await rom._buffer);

    _fetchNextFrameData();
  }

  Future<void> _playAudio(Float32List audio) async {
    print(audio.any((element) => element != 0));
    // player = await FlutterSoundPlayer().openPlayer();
    // await player?.startPlayerFromStream(codec: Codec.pcmFloat32, sampleRate: 44100);
    // player?.foodSink?.add(FoodData(audio.buffer.asUint8List()));
  }

  Future<void> _fetchNextFrameData() async {
    if (!_isStarting) return;
    final frameData = await _native.nesNextFrame(pointer: nesPointer);
    // final audioData = await _native.nesCopyAudio(pointer: nesPointer);
    // _playAudio(audioData);
    // Image.memory(bytes);
    ui.decodeImageFromPixels(frameData, 256, 240, ui.PixelFormat.rgba8888, (result) {
      _frameStreamController.add(result);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _fetchNextFrameData();
      });
    });
  }

  Future<void> reset() async {
    _isStarting = false;
    await _native.nesReset(pointer: nesPointer);
  }

  Future<void> pressButton(NesButton button) async {
    await _native.nesPressButton(pointer: nesPointer, button: button);
  }

  Future<void> releaseButton(NesButton button) async {
    await _native.nesReleaseButton(pointer: nesPointer, button: button);
  }

  Future<void> destroy() async {
    _isStarting = false;
    player?.foodSink?.add(FoodEvent(() {
      player?.stopPlayer();
    }));
    await player?.closePlayer();
    await _native.nesDestroy(pointer: nesPointer);
    _nesPointer = 0;
  }
}
