import Flutter
import UIKit

public class SwiftFlutterAdManagerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        registrar.register(BannerViewFactory(messenger: registrar.messenger()), withId: "plugins.adrianlogue.com/admanager/banner")

        let interstitialChannel = FlutterMethodChannel(name: "plugins.adrianlogue.com/admanager/interstitial", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(InterstitialAd(with: registrar, channel: interstitialChannel) as FlutterPlugin, channel: interstitialChannel)

        let rewardedChannel = FlutterMethodChannel(name: "plugins.adrianlogue.com/admanager/rewarded", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(RewardedAd(with: registrar, channel: rewardedChannel) as FlutterPlugin, channel: rewardedChannel)
    }
}
