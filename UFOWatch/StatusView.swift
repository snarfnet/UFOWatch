import SwiftUI

struct StatusView: View {
    @State private var isChecking = false
    @State private var checkResult: String?
    @State private var lastCheck = ReleaseChecker.lastCheckDescription

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Radar animation
                    ZStack {
                        Circle()
                            .stroke(.green.opacity(0.1), lineWidth: 1)
                            .frame(width: 200, height: 200)
                        Circle()
                            .stroke(.green.opacity(0.2), lineWidth: 1)
                            .frame(width: 150, height: 150)
                        Circle()
                            .stroke(.green.opacity(0.3), lineWidth: 1)
                            .frame(width: 100, height: 100)
                        Circle()
                            .fill(.green)
                            .frame(width: 12, height: 12)

                        if isChecking {
                            Circle()
                                .stroke(.green.opacity(0.5), lineWidth: 2)
                                .frame(width: 200, height: 200)
                                .scaleEffect(isChecking ? 1.5 : 1.0)
                                .opacity(isChecking ? 0 : 1)
                                .animation(.easeOut(duration: 1.5).repeatForever(autoreverses: false), value: isChecking)
                        }
                    }
                    .padding(.top, 30)

                    Text("PURSUE監視システム")
                        .font(.headline)
                        .foregroundStyle(.green)

                    Text("Presidential Unsealing and Reporting\nSystem for UAP Encounters")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    // Status cards
                    VStack(spacing: 12) {
                        StatusCard(
                            icon: "clock.arrow.circlepath",
                            title: "最終チェック",
                            value: lastCheck
                        )

                        StatusCard(
                            icon: "folder",
                            title: "公開リリース数",
                            value: "\(ReleaseData.allReleases.count) リリース"
                        )

                        StatusCard(
                            icon: "photo.on.rectangle.angled",
                            title: "公開資料数",
                            value: "\(ReleaseData.allItems.count) 件"
                        )

                        StatusCard(
                            icon: "globe.asia.australia",
                            title: "公式サイト",
                            value: "war.gov/UFO"
                        )
                    }
                    .padding(.horizontal)

                    if let result = checkResult {
                        Text(result)
                            .font(.subheadline)
                            .foregroundStyle(result.contains("新しい") ? .green : .secondary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 0.1, green: 0.1, blue: 0.15))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.horizontal)
                    }

                    Button {
                        checkNow()
                    } label: {
                        HStack {
                            if isChecking {
                                ProgressView()
                                    .tint(.black)
                                    .scaleEffect(0.8)
                            }
                            Text(isChecking ? "チェック中..." : "今すぐチェック")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.green)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(isChecking)
                    .padding(.horizontal)

                    Button {
                        NotificationHelper.requestPermission()
                    } label: {
                        HStack {
                            Image(systemName: "bell.badge")
                            Text("通知を有効にする")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.1, green: 0.1, blue: 0.15))
                        .foregroundStyle(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal)

                    BannerAdView()
                        .frame(height: 50)
                        .padding(.top, 8)
                }
            }
            .background(Color(red: 0.05, green: 0.05, blue: 0.1))
            .navigationTitle("ステータス")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color(red: 0.05, green: 0.05, blue: 0.1), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    private func checkNow() {
        isChecking = true
        checkResult = nil
        Task {
            let checker = ReleaseChecker()
            let hasNew = await checker.checkForNewRelease()
            await MainActor.run {
                isChecking = false
                lastCheck = ReleaseChecker.lastCheckDescription
                if hasNew {
                    checkResult = "新しい資料が公開されています！"
                } else {
                    checkResult = "現在の資料は最新です"
                }
            }
        }
    }
}

struct StatusCard: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(.green)
                .frame(width: 30)
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundStyle(.white)
        }
        .padding()
        .background(Color(red: 0.1, green: 0.1, blue: 0.15))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
