package com.adrianlogue.flutteradmanager

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterAdManagerPlugin {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            registrar
                .platformViewRegistry()
                .registerViewFactory(
                    "plugins.adrianlogue.com/admanager/banner", BannerViewFactory(registrar.messenger())
                )

            val interstitialChannel =
                MethodChannel(registrar.messenger(), "plugins.adrianlogue.com/admanager/interstitial")
            interstitialChannel.setMethodCallHandler(InterstitialAd(registrar, interstitialChannel))

            val rewardedChannel =
                MethodChannel(registrar.messenger(), "plugins.adrianlogue.com/admanager/rewarded")
            rewardedChannel.setMethodCallHandler(RewardedAd(registrar, rewardedChannel))
        }
    }
}
