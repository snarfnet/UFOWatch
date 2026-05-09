import SwiftUI
import BackgroundTasks
import GoogleMobileAds
import AppTrackingTransparency

@main
struct UFOWatchApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    @State private var attRequested = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onChange(of: scenePhase) { _, newPhase in
                    if newPhase == .active && !attRequested {
                        attRequested = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            ATTrackingManager.requestTrackingAuthorization { _ in }
                        }
                    }
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MobileAds.shared.start(completionHandler: nil)
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "com.tokyonasu.UFOWatch.refresh",
            using: nil
        ) { task in
            self.handleRefresh(task: task as! BGAppRefreshTask)
        }
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleRefresh()
    }

    func scheduleRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.tokyonasu.UFOWatch.refresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 24 * 60 * 60)
        try? BGTaskScheduler.shared.submit(request)
    }

    func handleRefresh(task: BGAppRefreshTask) {
        scheduleRefresh()
        let checker = ReleaseChecker()
        task.expirationHandler = { checker.cancel() }
        Task {
            let hasNew = await checker.checkForNewRelease()
            if hasNew {
                NotificationHelper.sendNewReleaseNotification()
            }
            task.setTaskCompleted(success: true)
        }
    }
}
