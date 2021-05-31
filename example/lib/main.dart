import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nes/flutter_nes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(builder: (context) {
          return TextButton(
            onPressed: () {
              NesRom rom = NesRom.asset("assets/SuperMario.nes");
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Nes(rom)));
            },
            child: Text("超级玛丽"),
          );
        }),
      ),
    );
  }
}

class Nes extends StatelessWidget {
  final NesRom rom;
  final FlutterNesController controller = FlutterNesController();

  Nes(this.rom, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "退出",
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          )),
                      SizedBox(width: 50),
                      FlutterNesButton(
                        controller: controller,
                        button: NesButton.Reset,
                        child: Text(
                          "重置",
                          style: TextStyle(color: Colors.orange, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  FlutterNesButton(controller: controller, button: NesButton.Joypad1Up),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlutterNesButton(controller: controller, button: NesButton.Joypad1Left),
                      SizedBox(width: 50),
                      FlutterNesButton(controller: controller, button: NesButton.Joypad1Right),
                    ],
                  ),
                  FlutterNesButton(controller: controller, button: NesButton.Joypad1Down),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
                width: size.height / 240 * 256,
                child: Center(
                    child: Transform.scale(
                        scale: size.height / 240, child: FlutterNesWidget(rom: rom, controller: controller)))),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlutterNesButton(
                        controller: controller,
                        button: NesButton.Start,
                        child: Text(
                          "开始/暂停",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                        ),
                      ),
                      SizedBox(width: 50),
                      FlutterNesButton(
                        controller: controller,
                        button: NesButton.Select,
                        child: Text(
                          "选择",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlutterNesButton(controller: controller, button: NesButton.Joypad1A),
                      SizedBox(width: 50),
                      FlutterNesButton(controller: controller, button: NesButton.Joypad1B),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
