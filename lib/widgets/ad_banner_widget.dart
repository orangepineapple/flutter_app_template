import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../theme/app_theme.dart';

/// Swap the placeholder below with a real AdWidget once you configure
/// your AdMob App ID in AndroidManifest / Info.plist and replace the
/// test ad-unit IDs with your own.
class AdBannerWidget extends StatelessWidget {
  const AdBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // ── PRODUCTION: Replace with real AdWidget ──────────────────────────
    // BannerAd _ad = BannerAd(
    //   adUnitId: Platform.isAndroid
    //       ? 'ca-app-pub-3940256099942544/6300978111'  // test id
    //       : 'ca-app-pub-3940256099942544/2934735716', // test id
    //   size: AdSize.banner,
    //   request: const AdRequest(),
    //   listener: BannerAdListener(),
    // )..load();
    // return SizedBox(height: 50, child: AdWidget(ad: _ad));
    // ────────────────────────────────────────────────────────────────────

    // Placeholder banner for development
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.primaryLight.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.ads_click, size: 16, color: AppTheme.primaryLight),
          const SizedBox(width: 8),
          Text(
            'Advertisement — Upgrade to Pro to remove ads',
            style: TextStyle(
              fontSize: 11,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
