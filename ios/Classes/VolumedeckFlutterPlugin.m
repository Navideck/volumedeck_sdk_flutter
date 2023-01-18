#import "VolumedeckFlutterPlugin.h"
#if __has_include(<volumedeck_flutter/volumedeck_flutter-Swift.h>)
#import <volumedeck_flutter/volumedeck_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "volumedeck_flutter-Swift.h"
#endif

@implementation VolumedeckFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVolumedeckFlutterPlugin registerWithRegistrar:registrar];
}
@end
