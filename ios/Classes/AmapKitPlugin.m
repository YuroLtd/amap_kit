#import "AmapKitPlugin.h"
#if __has_include(<amap_kit/amap_kit-Swift.h>)
#import <amap_kit/amap_kit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "amap_kit-Swift.h"
#endif

@implementation AmapKitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAmapKitPlugin registerWithRegistrar:registrar];
}
@end
