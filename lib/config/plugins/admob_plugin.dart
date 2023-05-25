import 'dart:async';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

// ! Replace this test ad unit with your own ad unit.
final adBannerId = Platform.isAndroid
    ? 'ca-app-pub-3863163313834291/1979108452'
    : 'ca-app-pub-3940256099942544/2934735716';

// ! Replace this test ad unit with your own ad unit.
final adInterstitialId = Platform.isAndroid
  ? 'ca-app-pub-3863163313834291/6759789707'
  : 'ca-app-pub-3940256099942544/4411468910';

// ! Replace this test ad unit with your own ad unit.
final adRewardedId = Platform.isAndroid
    ? 'ca-app-pub-3863163313834291/5612065858'
    : 'ca-app-pub-3940256099942544/1712485313';


class AdmobPlugin {


  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }


  static Future<BannerAd> loadBannerAd() async {

    return BannerAd(
      adUnitId: adBannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          print('$ad loaded.');
          
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          print('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();

  }


  static Future<InterstitialAd> loadInterstitialAd() async {

    Completer<InterstitialAd> completer = Completer();

    InterstitialAd.load(
        adUnitId: adInterstitialId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.

            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            completer.complete(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
            completer.completeError(error);
          },
        ));

      return completer.future;
  }


  /// Loads a rewarded ad.
  static Future<RewardedAd> loadRewardedAd() async {

    Completer<RewardedAd> completer = Completer();

    RewardedAd.load(
        adUnitId: adRewardedId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            print('$ad loaded.');

            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
              onAdShowedFullScreenContent: (ad) {},
              // Called when an impression occurs on the ad.
              onAdImpression: (ad) {},
              // Called when the ad failed to show full screen content.
              onAdFailedToShowFullScreenContent: (ad, err) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when the ad dismissed full screen content.
              onAdDismissedFullScreenContent: (ad) {
                // Dispose the ad here to free resources.
                ad.dispose();
              },
              // Called when a click is recorded for an ad.
              onAdClicked: (ad) {});


            // Keep a reference to the ad so you can show it later.
            completer.complete(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            completer.completeError(error);
          },
        ));

    return completer.future;
  }

}
