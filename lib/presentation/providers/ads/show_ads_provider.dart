import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';


const storeKey = 'showAds';

class ShowAdsNotifier extends StateNotifier<bool> {
  
  ShowAdsNotifier(): super(false) {
    checkAdsState();
  }
  

  void checkAdsState() async {
    state = await SharePreferencesPlugin.getBool(storeKey) ?? true;
  }

  void removeAds() {
    SharePreferencesPlugin.setBool(storeKey, false);
    state = false;
  }

  void showAds() {
    SharePreferencesPlugin.setBool(storeKey, true);
    state = true;
  }

  void toggleAds() {
    state ? removeAds() : showAds();
  }


}

final showAdsProvider = StateNotifierProvider<ShowAdsNotifier, bool>((ref) {
  return ShowAdsNotifier();
});