import SwiftUI

struct TimelineView: View {
    @State private var selectedItem: UFOItem?

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(ReleaseData.allReleases) { release in
                        Section {
                            ForEach(release.items) { item in
                                ItemCard(item: item)
                                    .onTapGesture { selectedItem = item }
                            }
                        } header: {
                            HStack {
                                Image(systemName: "folder.badge.gearshape")
                                    .foregroundStyle(.green)
                                Text("\(release.titleJa) — \(release.date)")
                                    .font(.headline)
                                Spacer()
                                Text("\(release.items.count)件")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal)
                            .padding(.top, 8)
                        }
                    }

                    BannerAdView()
                        .frame(height: 50)
                        .padding(.top, 8)
                }
                .padding(.vertical)
            }
            .background(Color(red: 0.05, green: 0.05, blue: 0.1))
            .navigationTitle("UFOウォッチ")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color(red: 0.05, green: 0.05, blue: 0.1), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(item: $selectedItem) { item in
                DetailView(item: item)
            }
        }
    }
}

struct ItemCard: View {
    let item: UFOItem

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: item.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 200)
                        .overlay {
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.gray)
                        }
                default:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .overlay { ProgressView().tint(.green) }
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    CategoryBadge(category: item.category)
                    Spacer()
                    Text(item.source)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.green.opacity(0.2))
                        .foregroundStyle(.green)
                        .clipShape(Capsule())
                }

                Text(item.descriptionJa)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .lineLimit(3)

                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundStyle(.green.opacity(0.7))
                    Text(item.locationJa)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Image(systemName: "calendar")
                        .foregroundStyle(.green.opacity(0.7))
                    Text(item.date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(12)
        }
        .background(Color(red: 0.1, green: 0.1, blue: 0.15))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }
}

struct CategoryBadge: View {
    let category: UFOCategory

    var badgeColor: Color {
        switch category {
        case .fbiInfrared: return .red
        case .fbiSketch: return .orange
        case .nasa: return .blue
        case .military: return .green
        }
    }

    var body: some View {
        Text(category.rawValue)
            .font(.caption2.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(badgeColor.opacity(0.3))
            .foregroundStyle(badgeColor)
            .clipShape(Capsule())
    }
}
