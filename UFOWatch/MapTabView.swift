import SwiftUI
import MapKit

struct MapTabView: View {
    @State private var selectedItem: UFOItem?
    @State private var position: MapCameraPosition = .automatic

    private var mappableItems: [UFOItem] {
        ReleaseData.allItems.filter { $0.latitude != nil && $0.longitude != nil }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Map(position: $position) {
                    ForEach(mappableItems) { item in
                        Annotation(item.locationJa, coordinate: CLLocationCoordinate2D(
                            latitude: item.latitude ?? 0,
                            longitude: item.longitude ?? 0
                        )) {
                            Button {
                                selectedItem = item
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(markerColor(for: item.category).opacity(0.3))
                                        .frame(width: 36, height: 36)
                                    Circle()
                                        .fill(markerColor(for: item.category))
                                        .frame(width: 16, height: 16)
                                    Circle()
                                        .stroke(.white, lineWidth: 2)
                                        .frame(width: 16, height: 16)
                                }
                            }
                        }
                    }
                }
                .mapStyle(.imagery(elevation: .realistic))

                VStack {
                    Spacer()
                    legendView
                        .padding(.bottom, 8)
                    BannerAdView()
                        .frame(height: 50)
                }
            }
            .navigationTitle("目撃マップ")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color(red: 0.05, green: 0.05, blue: 0.1), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(item: $selectedItem) { item in
                DetailView(item: item)
            }
        }
    }

    private func markerColor(for category: UFOCategory) -> Color {
        switch category {
        case .fbiInfrared: return .red
        case .fbiSketch: return .orange
        case .nasa: return .blue
        case .military: return .green
        }
    }

    private var legendView: some View {
        HStack(spacing: 12) {
            ForEach(UFOCategory.allCases, id: \.self) { cat in
                HStack(spacing: 4) {
                    Circle()
                        .fill(markerColor(for: cat))
                        .frame(width: 8, height: 8)
                    Text(cat.rawValue)
                        .font(.caption2)
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
    }
}
