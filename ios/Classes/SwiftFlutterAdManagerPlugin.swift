import Flutter
import UIKit

public class SwiftFlutterAdManagerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(BannerViewFactory(messenger: registrar.messenger()), withId: "plugins.adrianlogue.com/admanager/banner")
    }
}
