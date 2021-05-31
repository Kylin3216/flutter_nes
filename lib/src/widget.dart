import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'nes.dart';

///
/// Created by iceKylin on 2021/5/28
///
class FlutterNesWidget extends StatefulWidget {
  final FlutterNesController? controller;
  final NesRom rom;

  const FlutterNesWidget({required this.rom, this.controller, Key? key}) : super(key: key);

  @override
  _FlutterNesWidgetState createState() => _FlutterNesWidgetState();
}

class _FlutterNesWidgetState extends State<FlutterNesWidget> {
  FNesAsync? _fNes;
  ui.Image? _data;
  bool _dispose = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    _fNes = await FNesAsync.create();
    await _fNes?.setRom(widget.rom);
    await _fNes?.bootup();
    await _fNes?.step();
    _refresh();
  }

  void _refresh() async {
    if (_dispose) return;
    var time1 = DateTime.now();
    await _fNes?.stepFrame();
    var data = await _fNes?.getPixels();
    if (data != null) {
      ui.decodeImageFromPixels(data, 256, 240, ui.PixelFormat.rgba8888, (result) {
        if (mounted) {
          setState(() {
            _data = result;
          });
          var time2 = DateTime.now();
          var delta = time2.difference(time1).inMilliseconds;
          if (delta < 16) {
            Future.delayed(Duration(milliseconds: 16 - delta), () {
              _refresh();
            });
          } else {
            _refresh();
          }
        }
      });
    } else {
      _refresh();
    }
  }

  @override
  void dispose() {
    _dispose = true;
    _fNes?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller?._setUp(_fNes);
    return _data != null
        ? CustomPaint(
            painter: NesPainter(_data!),
            size: Size(256, 240),
          )
        : CupertinoActivityIndicator();
  }
}

class NesPainter extends CustomPainter {
  ui.Image image;

  NesPainter(this.image);

  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(image, Offset.zero, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as NesPainter).image != image;
  }
}

class FlutterNesButton extends StatelessWidget {
  final FlutterNesController controller;
  final NesButton button;
  final Widget? child;

  const FlutterNesButton({required this.controller, required this.button, this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (details) async {
          await controller.pressButton(button);
        },
        onTapUp: (details) async {
          await controller.releaseButton(button);
        },
        child: child ?? _defaultButton());
  }

  Widget _defaultButton() {
    late IconData data;
    switch (button) {
      case NesButton.Poweroff:
        data = Icons.power_off;
        break;
      case NesButton.Reset:
        data = Icons.refresh;
        break;
      case NesButton.Select:
        data = Icons.switch_left;
        break;
      case NesButton.Start:
        data = Icons.not_started_outlined;
        break;
      case NesButton.Joypad1A:
        data = Icons.text_format;
        break;
      case NesButton.Joypad1B:
        data = Icons.format_bold;
        break;
      case NesButton.Joypad1Up:
        data = Icons.keyboard_arrow_up;
        break;
      case NesButton.Joypad1Down:
        data = Icons.keyboard_arrow_down;
        break;
      case NesButton.Joypad1Left:
        data = Icons.keyboard_arrow_left;
        break;
      case NesButton.Joypad1Right:
        data = Icons.keyboard_arrow_right;
        break;
      case NesButton.Joypad2A:
        data = Icons.upload_sharp;
        break;
      case NesButton.Joypad2B:
        data = Icons.airline_seat_legroom_extra;
        break;
      case NesButton.Joypad2Up:
        data = Icons.airline_seat_legroom_extra;
        break;
      case NesButton.Joypad2Down:
        data = Icons.airline_seat_legroom_extra;
        break;
      case NesButton.Joypad2Left:
        data = Icons.airline_seat_legroom_extra;
        break;
      case NesButton.Joypad2Right:
        data = Icons.airline_seat_legroom_extra;
        break;
    }
    return Icon(data, size: 50);
  }
}

class FlutterNesController {
  FNesAsync? _fNesAsync;

  void _setUp(FNesAsync? fNes) {
    _fNesAsync = fNes;
  }

  Future<void> reset() async {
    await _fNesAsync?.reset();
  }

  Future<void> pressButton(NesButton button) async {
    await _fNesAsync?.pressButton(button);
  }

  Future<void> releaseButton(NesButton button) async {
    await _fNesAsync?.releaseButton(button);
  }
}
