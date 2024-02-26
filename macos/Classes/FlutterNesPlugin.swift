import Cocoa
import FlutterMacOS

public class FlutterNesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_nes", binaryMessenger: registrar.messenger)
    let instance = FlutterNesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    let dummy=dummy_method_to_enforce_bundling()
    print(dummy)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
