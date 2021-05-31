import Flutter
import UIKit

public class SwiftFlutterNesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_nes", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterNesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
  public static func dummyMethodToEnforceBundling() {
    let nes=create()
    let pointer=UnsafeMutablePointer<RomBuffer>.init(bitPattern: 10)
    set_rom(nes, pointer)
    bootup(nes)
    step(nes)
    step_frame(nes)
    reset(nes)
    get_pixels(nes)
    get_audio_buffer(nes)
    press_button(nes, 1)
    release_button(nes, 2)
    destory(nes)
   }
}
