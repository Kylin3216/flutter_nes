#import "FlutterNesPlugin.h"
#if __has_include(<flutter_nes/flutter_nes-Swift.h>)
#import <flutter_nes/flutter_nes-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_nes-Swift.h"
#endif

@implementation FlutterNesPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNesPlugin registerWithRegistrar:registrar];
}
@end
