import SwiftUI

struct DetailView: View {
    let item: UFOItem
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
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
                        case .failure:
                            Color.gray.opacity(0.3)
                                .frame(height: 300)
                                .overlay {
                                    Image(systemName: "exclamationmark.triangle")
                                        .font(.largeTitle)
                                        .foregroundStyle(.orange)
                                }
                        default:
                            Color.gray.opacity(0.2)
                                .frame(height: 300)
                                .overlay { ProgressView().tint(.green) }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text("ダブルタップ・ピンチで拡大")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)

                    VStack(alignment: .leading, spacing: 12) {
                        InfoRow(icon: "doc.text", label: "説明", value: item.descriptionJa)
                        InfoRow(icon: "globe", label: "英語", value: item.description)
                        InfoRow(icon: "mappin", label: "場所", value: item.locationJa)
                        InfoRow(icon: "calendar", label: "日付", value: item.date)
                        InfoRow(icon: "building.columns", label: "出典", value: item.source)

                        HStack {
                            CategoryBadge(category: item.category)
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(red: 0.1, green: 0.1, blue: 0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
            }
            .background(Color(red: 0.05, green: 0.05, blue: 0.1))
            .navigationTitle(item.locationJa)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color(red: 0.05, green: 0.05, blue: 0.1), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
        .presentationDragIndicator(.visible)
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(.green)
                .frame(width: 20)
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.subheadline)
                    .foregroundStyle(.white)
            }
        }
    }
}
