import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bridge.dart';
import 'nes.dart';

///
/// Created by iceKylin on 2021/5/28
///
class FlutterNesWidget extends StatefulWidget {
  final FlutterNesController? controller;
  final FlutterNesRom rom;

  const FlutterNesWidget({required this.rom, this.controller, Key? key}) : super(key: key);

  @override
  FlutterNesWidgetState createState() => FlutterNesWidgetState();
}

class FlutterNesWidgetState extends State<FlutterNesWidget> {
  late FlutterNes _fNes;

  late Future<void> _future;

  @override
  void initState() {
    _future = _init();
    super.initState();
  }

  Future<void> _init() async {
    _fNes = await FlutterNes.create();
    widget.controller?._setUp(_fNes);
    await _fNes.start(widget.rom);
  }

  @override
  void dispose() {
    _fNes.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder<ui.Image>(
              stream: _fNes.frameStream,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.active) {
                  if (snap.data != null) {
                    return CustomPaint(
                      size: const Size(256, 240),
                      painter: NesPainter(snap.data!),
                    );
                  }
                }
                return const CupertinoActivityIndicator();
              },
            );
          }
          return const CupertinoActivityIndicator();
        });
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

  const FlutterNesButton({required this.controller, required this.button, this.child, Key? key})
      : super(key: key);

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
      case NesButton.PowerOff:
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
      case NesButton.JoyPad1A:
        data = Icons.text_format;
        break;
      case NesButton.JoyPad1B:
        data = Icons.format_bold;
        break;
      case NesButton.JoyPad1Up:
        data = Icons.keyboard_arrow_up;
        break;
      case NesButton.JoyPad1Down:
        data = Icons.keyboard_arrow_down;
        break;
      case NesButton.JoyPad1Left:
        data = Icons.keyboard_arrow_left;
        break;
      case NesButton.JoyPad1Right:
        data = Icons.keyboard_arrow_right;
        break;
      case NesButton.JoyPad2A:
        data = Icons.upload_sharp;
        break;
      case NesButton.JoyPad2B:
        data = Icons.airline_seat_legroom_extra;
        break;
      case NesButton.JoyPad2Up:
        data = Icons.airline_seat_legroom_extra;
        break;
      case NesButton.JoyPad2Down:
        data = Icons.airline_seat_legroom_extra;
        break;
      case NesButton.JoyPad2Left:
        data = Icons.airline_seat_legroom_extra;
        break;
      case NesButton.JoyPad2Right:
        data = Icons.airline_seat_legroom_extra;
        break;
    }
    return Icon(data, size: 50);
  }
}

class FlutterNesController {
  FlutterNes? _fNes;

  void _setUp(FlutterNes? fNes) {
    _fNes = fNes;
  }

  Future<void> reset() async {
    await _fNes?.reset();
  }

  Future<void> pressButton(NesButton button) async {
    await _fNes?.pressButton(button);
  }

  Future<void> releaseButton(NesButton button) async {
    await _fNes?.releaseButton(button);
  }
}
