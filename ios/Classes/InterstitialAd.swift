import GoogleMobileAds

class InterstitialAd: SwiftFlutterAdManagerPlugin {
    // private var interstitialAd: GAMInterstitialAd?
    var interstitial: GAMInterstitialAd
    private let channel: FlutterMethodChannel!

    public init(with _: FlutterPluginRegistrar, channel: FlutterMethodChannel) {
        self.channel = channel
        super.init()
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            self.handle(call, result: result)
        })
    }

    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "load":
            load(call, result: result)
        case "show":
            show(call, result: result)
        case "dispose":
            dispose(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func load(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let argument = call.arguments as! Dictionary<String, Any>
        let isDevelop = argument["isDevelop"] as? Bool ?? false
        let customTargeting = argument["customTargeting"] as? [String: String]

        let adUnitId = argument["adUnitId"] as! String
        if isDevelop {
            // interstitialAd = GAMInterstitialAd(adUnitID: "/6499/example/interstitial")
            // interstitialAd.load(withAdUnitID: "/6499/example/interstitial")
            // let adId = "/6499/example/interstitial"
            interstitial.adUnitID = "/6499/example/interstitial"
        } else {
            
            // interstitialAd = GAMInterstitialAd(adUnitID: adUnitId)
            // interstitialAd.load(withAdUnitID: adUnitId)
            // let adId = adUnitId
            interstitial.adUnitID = adUnitId
        }
        
        interstitialAd!.delegate = self

        let request = GAMRequest()
        request.customTargeting = customTargeting
        interstitialAd!.load(request)
        // interstitialAd!.load(
        //     withAdUnitID: adUnitId, 
        //     request: request,
        //     completionHandler: { [self] ad, error in
        //         if let error = error {
        //             print("Failed to load interstitial ad with error: \(error.localizedDescription)")
        //             return
        //         }
        //         interstitial = ad
        //     })

        result(nil)
    }

    private func show(_: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let interstitialAd = interstitialAd else {
            result(FlutterError(code: "program_error", message: "Please call load() method first.", details: nil))
            return
        }

        if interstitialAd.isReady {
            let roolViewControlelr = UIApplication.shared.delegate!.window!!.rootViewController!
            interstitialAd.present(fromRootViewController: roolViewControlelr)
            result(nil)
        } else {
            result(FlutterError(code: "not_loaded_yet", message: "The interstitial wasn't loaded yet.", details: nil))
        }
    }

    private func dispose(_: FlutterMethodCall, result: @escaping FlutterResult) {
        result(nil)
    }
}

extension InterstitialAd: GADFullScreenContentDelegate {
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GAMInterstitialAd) {
        channel.invokeMethod("onAdLoaded", arguments: nil)
    }

    /// Tells the delegate an ad request failed.
    func interstitial(_: GAMInterstitialAd, didFailToReceiveAdWithError error: NSError) {
        channel.invokeMethod("onAdFailedToLoad", arguments: ["errorCode": error.code])
    }

    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_: GAMInterstitialAd) {
        channel.invokeMethod("onAdOpened", arguments: nil)
    }

    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GAMInterstitialAd) {
        interstitialAd = GAMInterstitialAd(withAdUnitID: ad.adUnitID!)
        interstitialAd?.delegate = self
    }

    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_: GAMInterstitialAd) {
        channel.invokeMethod("onAdClosed", arguments: nil)
    }

    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_: GAMInterstitialAd) {
        channel.invokeMethod("onAdLeftApplication", arguments: nil)
    }
}