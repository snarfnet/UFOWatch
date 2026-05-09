import SwiftUI

struct DetailView: View {
    let item: UFOItem
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                PursueBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        cinematicHeader
                        evidenceImage
                        Text("ダブルタップ、ピンチで画像を検証")
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(PursueTheme.muted)
                            .frame(maxWidth: .infinity)

                        dossier
                    }
                    .padding(16)
                }
            }
            .navigationTitle(item.locationJa)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(PursueTheme.void, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(PursueTheme.muted)
                    }
                }
            }
        }
        .presentationDragIndicator(.visible)
    }

    private var cinematicHeader: some View {
        ZStack(alignment: .bottomLeading) {
            CinematicStill(cornerRadius: 8)
                .frame(height: 220)
            VStack(alignment: .leading, spacing: 6) {
                Text("CASE FILE")
                    .font(.system(.caption, design: .monospaced).weight(.black))
                    .foregroundStyle(PursueTheme.lime)
                Text(item.locationJa)
                    .font(.title2.weight(.black))
                    .foregroundStyle(PursueTheme.ink)
            }
            .padding(14)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.12), lineWidth: 1)
        )
    }

    private var evidenceImage: some View {
        AsyncImage(url: URL(string: item.imageURL)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(scale)
                    .offset(offset)
                    .gesture(
                        MagnifyGesture()
                            .onChanged { value in
                                scale = max(1.0, min(5.0, value.magnification))
                            }
                            .onEnded { _ in
                                withAnimation {
                                    if scale < 1.2 {
                                        scale = 1.0
                                        offset = .zero
                                    }
                                }
                            }
                    )
                    .simultaneousGesture(
                        DragGesture()
                            .onChanged { value in
                                if scale > 1.0 {
                                    offset = CGSize(
                                        width: lastOffset.width + value.translation.width,
                                        height: lastOffset.height + value.translation.height
                                    )
                                }
                            }
                            .onEnded { _ in
                                lastOffset = offset
                            }
                    )
                    .onTapGesture(count: 2) {
                        withAnimation {
                            if scale > 1.0 {
                                scale = 1.0
                                offset = .zero
                                lastOffset = .zero
                            } else {
                                scale = 3.0
                            }
                        }
                    }
                    .overlay(alignment: .topLeading) {
                        Text("EVIDENCE")
                            .font(.system(size: 10, weight: .black, design: .monospaced))
                            .foregroundStyle(PursueTheme.void)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(item.category.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                            .padding(10)
                    }
            case .failure:
                Rectangle()
                    .fill(PursueTheme.panel)
                    .frame(height: 300)
                    .overlay {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(PursueTheme.amber)
                    }
            default:
                Rectangle()
                    .fill(PursueTheme.panel)
                    .frame(height: 300)
                    .overlay { ProgressView().tint(PursueTheme.lime) }
            }
        }
        .frame(maxWidth: .infinity)
        .background(PursueTheme.void)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(item.category.accentColor.opacity(0.42), lineWidth: 1)
        )
    }

    private var dossier: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("翻訳済み記録")
                        .font(.system(.caption, design: .monospaced).weight(.black))
                        .foregroundStyle(PursueTheme.lime)
                    Text(item.descriptionJa)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(PursueTheme.ink)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                CategoryBadge(category: item.category)
            }

            Divider()
                .overlay(PursueTheme.lime.opacity(0.2))

            InfoRow(icon: "globe.americas.fill", label: "原文", value: item.description)
            InfoRow(icon: "mappin.and.ellipse", label: "場所", value: item.locationJa)
            InfoRow(icon: "calendar", label: "日付", value: item.date)
            InfoRow(icon: "building.columns", label: "出典", value: item.source)
            InfoRow(icon: "link", label: "分類", value: item.category.rawValue)
        }
        .padding(16)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.12), lineWidth: 1)
        )
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(PursueTheme.lime)
                .frame(width: 22)
            VStack(alignment: .leading, spacing: 3) {
                Text(label)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(PursueTheme.muted)
                Text(value)
                    .font(.subheadline)
                    .foregroundStyle(PursueTheme.ink)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
