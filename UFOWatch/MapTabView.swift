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
                                MapMarker(category: item.category)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .mapStyle(.imagery(elevation: .realistic))
                .ignoresSafeArea(edges: .bottom)

                Image("CinematicHero")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.22)
                    .blendMode(.screen)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)

                LinearGradient(
                    colors: [PursueTheme.void.opacity(0.88), .clear, PursueTheme.void.opacity(0.78)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .allowsHitTesting(false)

                VStack(spacing: 0) {
                    coordinateHeader
                    Spacer()
                    legendView
                        .padding(.horizontal, 16)
                        .padding(.bottom, 10)
                    BannerAdView()
                        .frame(height: 50)
                }
            }
            .navigationTitle("座標")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(PursueTheme.void, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(item: $selectedItem) { item in
                DetailView(item: item)
            }
        }
    }

    private var coordinateHeader: some View {
        HStack(spacing: 10) {
            Image(systemName: "viewfinder")
                .foregroundStyle(PursueTheme.lime)
            VStack(alignment: .leading, spacing: 2) {
                Text("GLOBAL SIGHTING COORDINATES")
                    .font(.system(size: 11, weight: .black, design: .monospaced))
                    .foregroundStyle(PursueTheme.lime)
                Text("タップで資料を開く")
                    .font(.caption)
                    .foregroundStyle(PursueTheme.muted)
            }
            Spacer()
            Text("\(mappableItems.count)")
                .font(.system(.headline, design: .monospaced).weight(.black))
                .foregroundStyle(PursueTheme.ink)
        }
        .padding(14)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.12), lineWidth: 1)
        )
        .padding(16)
    }

    private var legendView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("分類")
                .font(.system(size: 10, weight: .black, design: .monospaced))
                .foregroundStyle(PursueTheme.muted)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 68), spacing: 8)], spacing: 8) {
                ForEach(UFOCategory.allCases, id: \.self) { category in
                    HStack(spacing: 5) {
                        Circle()
                            .fill(category.accentColor)
                            .frame(width: 8, height: 8)
                        Text(category.shortName)
                            .font(.system(size: 10, weight: .black, design: .monospaced))
                            .foregroundStyle(PursueTheme.ink)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background(category.accentColor.opacity(0.18), in: RoundedRectangle(cornerRadius: 4))
                }
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.12), lineWidth: 1)
        )
    }
}

private struct MapMarker: View {
    let category: UFOCategory

    var body: some View {
        ZStack {
            Circle()
                .fill(category.accentColor.opacity(0.24))
                .frame(width: 44, height: 44)
            Circle()
                .stroke(category.accentColor.opacity(0.75), lineWidth: 1)
                .frame(width: 32, height: 32)
            Circle()
                .fill(category.accentColor)
                .frame(width: 12, height: 12)
                .shadow(color: category.accentColor, radius: 8)
            Image(systemName: "chevron.up")
                .font(.system(size: 9, weight: .black))
                .foregroundStyle(PursueTheme.void)
                .offset(y: -1)
        }
    }
}
