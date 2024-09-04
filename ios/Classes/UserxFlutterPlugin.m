#import "UserxFlutterPlugin.h"
#if __has_include(<userx_flutter/userx_flutter-Swift.h>)
#import <userx_flutter/userx_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "userx_flutter-Swift.h"
#endif

@implementation UserxFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUserxFlutterPlugin registerWithRegistrar:registrar];
}
@end
