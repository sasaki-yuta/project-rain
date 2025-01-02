// admob
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

void addBanner() {
  final bannerId = getAdBannerUnitId();
  BannerAd myBanner = BannerAd(
      adUnitId: bannerId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener()
  );
  myBanner.load();
}

String getAdBannerUnitId() {
  // 公開時にデバッグモードを解除する = "";
  String bannerUnitId = "kDebugMode";
  // Android のとき
  bannerUnitId = kDebugMode ?
  "ca-app-pub-3940256099942544/6300978111"  // Androidのデモ用バナー広告ID
      : "ca-app-pub-3106594758397593/6969125267";
/*
  // iOSのとき
  bannerUnitId = kDebugMode
      ? "ca-app-pub-3940256099942544/2934735716"  // iOSのデモ用バナー広告ID
      : "YOUR_ADMOB_IOS_UNIT_ID";
*/
  return bannerUnitId;
}
