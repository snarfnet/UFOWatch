import Foundation
import UserNotifications

class ReleaseChecker: @unchecked Sendable {
    private var task: URLSessionDataTask?
    private static let lastReleaseKey = "lastKnownReleaseCount"
    private static let lastCheckKey = "lastCheckDate"

    func cancel() {
        task?.cancel()
    }

    func checkForNewRelease() async -> Bool {
        guard let url = URL(string: "https://www.war.gov/UFO/") else { return false }

        do {
            var request = URLRequest(url: url)
            request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X)", forHTTPHeaderField: "User-Agent")
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let html = String(data: data, encoding: .utf8) else { return false }

            let releaseCount = countReleases(in: html)
            let lastKnown = UserDefaults.standard.integer(forKey: Self.lastReleaseKey)

            UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: Self.lastCheckKey)

            if lastKnown == 0 {
                UserDefaults.standard.set(releaseCount, forKey: Self.lastReleaseKey)
                return false
            }

            if releaseCount > lastKnown {
                UserDefaults.standard.set(releaseCount, forKey: Self.lastReleaseKey)
                return true
            }

            return false
        } catch {
            return false
        }
    }

    private func countReleases(in html: String) -> Int {
        var count = 0
        var searchRange = html.startIndex..<html.endIndex
        while let range = html.range(of: "Release ", options: .caseInsensitive, range: searchRange) {
            let afterRelease = range.upperBound
            if afterRelease < html.endIndex {
                let nextChars = html[afterRelease..<min(html.index(afterRelease, offsetBy: 3, limitedBy: html.endIndex) ?? html.endIndex, html.endIndex)]
                if nextChars.allSatisfy({ $0.isNumber }) {
                    count += 1
                }
            }
            searchRange = range.upperBound..<html.endIndex
        }
        return max(count, 1)
    }

    static var lastCheckDescription: String {
        let ts = UserDefaults.standard.double(forKey: lastCheckKey)
        guard ts > 0 else { return "未チェック" }
        let date = Date(timeIntervalSince1970: ts)
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.localizedString(for: date, relativeTo: Date())
    }

    static var currentReleaseCount: Int {
        UserDefaults.standard.integer(forKey: lastReleaseKey)
    }
}

struct NotificationHelper {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    static func sendNewReleaseNotification() {
        let content = UNMutableNotificationContent()
        content.title = "UFOウォッチ"
        content.body = "新しいUAP資料が公開されました"
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )
        UNUserNotificationCenter.current().add(request)
    }
}
