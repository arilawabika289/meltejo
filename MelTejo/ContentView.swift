import SwiftUI

struct ContentView: View {
    @StateObject private var store = MelTejoStore()
    @AppStorage("meltejo.onboarding.completed") private var onboardingCompleted = false
    @AppStorage(AppLanguage.storageKey) private var selectedLanguageRawValue = AppLanguage.current.rawValue

    var body: some View {
        Group {
            if onboardingCompleted {
                TabView {
                    HomeView()
                        .environmentObject(store)
                        .tabItem { Label(L.s("Studio"), systemImage: "house.fill") }

                    TrainingView()
                        .environmentObject(store)
                        .tabItem { Label(L.s("Throw Lab"), systemImage: "dial.high.fill") }

                    MatchCenterView()
                        .environmentObject(store)
                        .tabItem { Label(L.s("Session Deck"), systemImage: "rectangle.stack.fill") }

                    ExploreView()
                        .environmentObject(store)
                        .tabItem { Label(L.s("Atlas"), systemImage: "map.fill") }

                    CultureView()
                        .environmentObject(store)
                        .tabItem { Label(L.s("Signature"), systemImage: "waveform.path.ecg") }
                }
                .tint(BrandPalette.accent)
                .toolbarBackground(BrandPalette.background, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
            } else {
                OnboardingView {
                    onboardingCompleted = true
                }
            }
        }
        .id(selectedLanguageRawValue)
        .preferredColorScheme(.dark)
    }
}
