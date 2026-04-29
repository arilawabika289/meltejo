import AnalyticsKit
import SwiftUI

@main
struct MelTejoApp: App {
    var body: some Scene {
        WindowGroup {
            AnalyticsEntry(
                config: MelAnalyticsConfig.live,
                languageCode: AppLanguage.current.rawValue,
                requestReviewBeforeCheck: false
            ) {
                ContentView()
            }
        }
    }
}
