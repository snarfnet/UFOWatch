import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-9404799280370656/5733826952"
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        return bannerView
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let root = windowScene.windows.first?.rootViewController {
            uiView.rootViewController = root
            uiView.load(GADRequest())
        }
    }
}
