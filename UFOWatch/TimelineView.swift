import SwiftUI

struct TimelineView: View {
    @State private var selectedItem: UFOItem?

    var body: some View {
        NavigationStack {
            ZStack {
                PursueBackground()

                ScrollView {
                    VStack(spacing: 18) {
                        HeroPanel()

                        ForEach(ReleaseData.allReleases) { release in
                            ReleaseSection(release: release, selectedItem: $selectedItem)
                        }

                        BannerAdView()
                            .frame(height: 50)
                            .padding(.top, 2)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 18)
                }
            }
            .navigationTitle("PURSUE")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(PursueTheme.void, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(item: $selectedItem) { item in
                DetailView(item: item)
            }
        }
    }
}

private struct HeroPanel: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            ZStack(alignment: .bottomLeading) {
                CinematicStill(cornerRadius: 8)
                    .frame(height: 360)
                    .overlay(alignment: .topLeading) {
                        Text("FIELD SIGNAL")
                            .font(.system(size: 10, weight: .black, design: .monospaced))
                            .foregroundStyle(PursueTheme.void)
                            .padding(.horizontal, 9)
                            .padding(.vertical, 5)
                            .background(PursueTheme.lime)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                            .padding(14)
                    }

                heroCopy
                    .padding(16)
            }

            HStack(spacing: 10) {
                MetricPill(value: "\(ReleaseData.allItems.count)", label: "資料")
                MetricPill(value: "\(ReleaseData.allReleases.count)", label: "公開回")
                MetricPill(value: "\(ReleaseData.allItems.filter { $0.latitude != nil }.count)", label: "座標")
            }
        }
        .padding(16)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
        .overlay(alignment: .topTrailing) {
            Text("LIVE INDEX")
                .font(.system(size: 10, weight: .black, design: .monospaced))
                .foregroundStyle(PursueTheme.void)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(PursueTheme.lime)
                .clipShape(RoundedRectangle(cornerRadius: 3))
                .padding(12)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.12), lineWidth: 1)
        )
    }

    private var heroCopy: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("UAP WATCH")
                .font(.system(.caption, design: .monospaced).weight(.bold))
                .foregroundStyle(PursueTheme.lime)
            Text("米国UFO資料を日本語で追跡")
                .font(.system(.title2, design: .rounded).weight(.black))
                .foregroundStyle(PursueTheme.ink)
                .fixedSize(horizontal: false, vertical: true)
            Text("公式公開、赤外線画像、軍事記録、目撃座標を映画のような監視画面に集約。")
                .font(.footnote)
                .foregroundStyle(PursueTheme.muted)
                .lineSpacing(2)
        }
    }
}

private struct ReleaseSection: View {
    let release: UFORelease
    @Binding var selectedItem: UFOItem?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: "folder.badge.gearshape")
                    .foregroundStyle(PursueTheme.amber)
                VStack(alignment: .leading, spacing: 2) {
                    Text(release.titleJa)
                        .font(.headline.weight(.bold))
                        .foregroundStyle(PursueTheme.ink)
                    Text("公開日 \(release.date)")
                        .font(.caption)
                        .foregroundStyle(PursueTheme.muted)
                }
                Spacer()
                Text("\(release.items.count)件")
                    .font(.system(.caption, design: .monospaced).weight(.bold))
                    .foregroundStyle(PursueTheme.lime)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(PursueTheme.lime.opacity(0.13), in: Capsule())
            }

            LazyVStack(spacing: 12) {
                ForEach(release.items) { item in
                    ItemCard(item: item)
                        .onTapGesture { selectedItem = item }
                }
            }
        }
    }
}

struct ItemCard: View {
    let item: UFOItem

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: item.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay(ImageScanOverlay())
                case .failure:
                    ImagePlaceholder(icon: "exclamationmark.triangle")
                default:
                    ImagePlaceholder(icon: "dot.radiowaves.left.and.right")
                        .overlay { ProgressView().tint(PursueTheme.lime) }
                }
            }
            .frame(width: 112, height: 112)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(item.category.accentColor.opacity(0.5), lineWidth: 1)
            )

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    CategoryBadge(category: item.category)
                    Text(item.source)
                        .font(.system(size: 10, weight: .black, design: .monospaced))
                        .foregroundStyle(PursueTheme.muted)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(PursueTheme.lime.opacity(0.72))
                }

                Text(item.descriptionJa)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(PursueTheme.ink)
                    .lineLimit(3)
                    .lineSpacing(2)

                HStack(spacing: 10) {
                    Label(item.locationJa, systemImage: "mappin.and.ellipse")
                    Label(item.date, systemImage: "calendar")
                }
                .font(.caption2.weight(.semibold))
                .foregroundStyle(PursueTheme.muted)
                .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}

private struct ImagePlaceholder: View {
    let icon: String

    var body: some View {
        Rectangle()
            .fill(PursueTheme.midnight)
            .overlay {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(PursueTheme.lime.opacity(0.75))
            }
    }
}

private struct ImageScanOverlay: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                colors: [.clear, PursueTheme.void.opacity(0.74)],
                startPoint: .top,
                endPoint: .bottom
            )
            VStack(spacing: 5) {
                ForEach(0..<5, id: \.self) { _ in
                    Rectangle()
                        .fill(PursueTheme.lime.opacity(0.08))
                        .frame(height: 1)
                }
            }
            .padding(8)
        }
    }
}

struct CategoryBadge: View {
    let category: UFOCategory

    var body: some View {
        Text(category.shortName)
            .font(.system(size: 10, weight: .black, design: .monospaced))
            .padding(.horizontal, 7)
            .padding(.vertical, 4)
            .background(category.accentColor.opacity(0.18), in: RoundedRectangle(cornerRadius: 4))
            .foregroundStyle(category.accentColor)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(category.accentColor.opacity(0.38), lineWidth: 1)
            )
    }
}
