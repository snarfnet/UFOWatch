import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView()
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.translatesAutoresizingMaskIntoConstraints = false
        return banner
    }

    func updateUIView(_ uiView: BannerView, context: Context) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let root = windowScene.windows.first?.rootViewController {
            uiView.rootViewController = root
            uiView.load(Request())
        }
    }
}
