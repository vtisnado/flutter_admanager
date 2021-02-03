#import "FlutterAdManagerPlugin.h"
#import <flutter_admanager/flutter_admanager-Swift.h>

@implementation FlutterAdManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAdManagerPlugin registerWithRegistrar:registrar];
}
@end
