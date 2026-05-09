import SwiftUI

struct StatusView: View {
    @State private var isChecking = false
    @State private var checkResult: String?
    @State private var lastCheck = ReleaseChecker.lastCheckDescription

    var body: some View {
        NavigationStack {
            ZStack {
                PursueBackground()

                ScrollView {
                    VStack(spacing: 18) {
                        monitorHeader
                        statusGrid
                        resultPanel
                        actionButtons

                        BannerAdView()
                            .frame(height: 50)
                            .padding(.top, 2)
                    }
                    .padding(16)
                }
            }
            .navigationTitle("監視")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(PursueTheme.void, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    private var monitorHeader: some View {
        ZStack(alignment: .bottom) {
            CinematicStill(cornerRadius: 8)
                .frame(height: 330)
                .overlay(Color.black.opacity(0.18))
            VStack(spacing: 5) {
                Text("PURSUE MONITOR")
                    .font(.system(.title3, design: .monospaced).weight(.black))
                    .foregroundStyle(PursueTheme.lime)
                Text("米国公式UFO公開情報を巡回")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(PursueTheme.ink)
                Text("新しい資料を検知したら通知で知らせます。")
                    .font(.caption)
                    .foregroundStyle(PursueTheme.muted)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [PursueTheme.void.opacity(0), PursueTheme.void.opacity(0.82)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.12), lineWidth: 1)
        )
    }

    private var statusGrid: some View {
        VStack(spacing: 10) {
            StatusCard(icon: "clock.arrow.circlepath", title: "最終チェック", value: lastCheck)
            StatusCard(icon: "folder", title: "公開リリース", value: "\(ReleaseData.allReleases.count) 件")
            StatusCard(icon: "photo.on.rectangle.angled", title: "登録資料", value: "\(ReleaseData.allItems.count) 点")
            StatusCard(icon: "globe.americas.fill", title: "巡回先", value: "war.gov/UFO")
        }
    }

    @ViewBuilder
    private var resultPanel: some View {
        if let result = checkResult {
            HStack(spacing: 10) {
                Image(systemName: result.contains("新しい") ? "exclamationmark.triangle.fill" : "checkmark.seal.fill")
                    .foregroundStyle(result.contains("新しい") ? PursueTheme.amber : PursueTheme.lime)
                Text(result)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(PursueTheme.ink)
                Spacer()
            }
            .padding()
            .background(PursueTheme.panelHigh.opacity(0.9), in: RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(PursueTheme.lime.opacity(0.18), lineWidth: 1)
            )
        }
    }

    private var actionButtons: some View {
        VStack(spacing: 10) {
            Button {
                checkNow()
            } label: {
                HStack {
                    if isChecking {
                        ProgressView()
                            .tint(PursueTheme.void)
                            .scaleEffect(0.8)
                    } else {
                        Image(systemName: "arrow.triangle.2.circlepath")
                    }
                    Text(isChecking ? "巡回中..." : "今すぐ巡回")
                        .fontWeight(.black)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(PursueTheme.lime, in: RoundedRectangle(cornerRadius: 8))
                .foregroundStyle(PursueTheme.void)
            }
            .disabled(isChecking)

            Button {
                NotificationHelper.requestPermission()
            } label: {
                HStack {
                    Image(systemName: "bell.badge")
                    Text("通知を有効にする")
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(PursueTheme.panel.opacity(0.9), in: RoundedRectangle(cornerRadius: 8))
                .foregroundStyle(PursueTheme.lime)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(PursueTheme.lime.opacity(0.22), lineWidth: 1)
                )
            }
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
                checkResult = hasNew ? "新しい資料が公開されています" : "現在の資料は最新です"
            }
        }
    }
}

struct StatusCard: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(PursueTheme.lime)
                .frame(width: 28)
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(PursueTheme.muted)
            Spacer()
            Text(value)
                .font(.system(.subheadline, design: .monospaced).weight(.bold))
                .foregroundStyle(PursueTheme.ink)
                .multilineTextAlignment(.trailing)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}
