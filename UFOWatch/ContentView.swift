import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TimelineView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("タイムライン")
                }
                .tag(0)

            MapTabView()
                .tabItem {
                    Image(systemName: "map")
                    Text("マップ")
                }
                .tag(1)

            StatusView()
                .tabItem {
                    Image(systemName: "antenna.radiowaves.left.and.right")
                    Text("ステータス")
                }
                .tag(2)
        }
        .tint(.green)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.1, alpha: 1)
            appearance.stackedLayoutAppearance.normal.iconColor = .gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(.green)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(.green)]
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
