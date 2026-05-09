import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TimelineView()
                .tabItem {
                    Image(systemName: "viewfinder")
                    Text("追跡")
                }
                .tag(0)

            MapTabView()
                .tabItem {
                    Image(systemName: "globe.americas.fill")
                    Text("座標")
                }
                .tag(1)

            StatusView()
                .tabItem {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                    Text("監視")
                }
                .tag(2)
        }
        .tint(PursueTheme.lime)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 0.015, green: 0.025, blue: 0.035, alpha: 0.98)
            appearance.shadowColor = UIColor(red: 0.22, green: 0.95, blue: 0.42, alpha: 0.18)
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 0.47, green: 0.54, blue: 0.52, alpha: 1)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(red: 0.47, green: 0.54, blue: 0.52, alpha: 1)]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(PursueTheme.lime)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(PursueTheme.lime)]
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
