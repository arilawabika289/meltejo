import SwiftUI

struct CultureView: View {
    @EnvironmentObject private var store: MelTejoStore
    @State private var showingClearAlert = false
    @AppStorage(AppLanguage.storageKey) private var selectedLanguageRawValue = AppLanguage.current.rawValue

    var body: some View {
        MelScrollCanvas(title: L.s("Signature")) {
            MelHeader(
                eyebrow: L.s("Signature"),
                title: L.s("Read your tejo identity, not just your counts."),
                subtitle: L.s("Mel Tejo looks for tendencies: how often you score, how often you chase premium contact, and what kind of thrower is taking shape.")
            )

            signatureHero
            settingsCard
            metrics
            resultBreakdown
            cultureFacts
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(L.s("Clear")) {
                    showingClearAlert = true
                }
            }
        }
        .alert(L.s("Clear all saved Mel Tejo data?"), isPresented: $showingClearAlert) {
            Button(L.s("Cancel"), role: .cancel) {}
            Button(L.s("Clear"), role: .destructive) {
                store.clearAllStats()
            }
        }
    }

    private var signatureHero: some View {
        MelCard {
            Text(L.s("Current archetype"))
                .font(.headline)
                .foregroundStyle(BrandPalette.text)
            Text(store.signatureTitle)
                .font(.largeTitle.weight(.black))
                .foregroundStyle(BrandPalette.accent)
            Text(store.signatureNote)
                .font(.subheadline)
                .foregroundStyle(BrandPalette.secondaryText)
        }
    }

    private var settingsCard: some View {
        MelCard {
            Text(L.s("Settings"))
                .font(.headline)
                .foregroundStyle(BrandPalette.text)

            VStack(alignment: .leading, spacing: 10) {
                Text(L.s("App language"))
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(BrandPalette.secondaryText)

                Picker(L.s("App language"), selection: $selectedLanguageRawValue) {
                    ForEach(AppLanguage.allCases) { language in
                        Text(language.displayName).tag(language.rawValue)
                    }
                }
                .pickerStyle(.segmented)

                Text(L.s("Choose the language used inside Mel Tejo without changing your iPhone system language."))
                    .font(.caption)
                    .foregroundStyle(BrandPalette.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var metrics: some View {
        let items: [SignatureMetric] = [
            SignatureMetric(id: "scoring-rate", title: L.s("Scoring rate"), value: "\(Int(store.scoringAccuracy * 100))%", detail: L.s("Throws that stayed productive.")),
            SignatureMetric(id: "premium-rate", title: L.s("Premium rate"), value: "\(Int(store.premiumRate * 100))%", detail: L.s("Bocin and moñona frequency.")),
            SignatureMetric(id: "average-power", title: L.s("Average power"), value: "\(Int(store.averagePower))", detail: L.s("How hard you tend to release.")),
            SignatureMetric(id: "average-composure", title: L.s("Average composure"), value: "\(Int(store.averageComposure))", detail: L.s("How calm the profile feels."))
        ]

        return VStack(alignment: .leading, spacing: 12) {
            SectionTitle(
                title: L.s("Profile metrics"),
                detail: L.s("These numbers matter because they describe style, not just volume.")
            )

            ForEach(items) { item in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(.headline)
                            .foregroundStyle(BrandPalette.text)
                        Text(item.detail)
                            .font(.caption)
                            .foregroundStyle(BrandPalette.secondaryText)
                    }
                    Spacer()
                    Text(item.value)
                        .font(.title3.monospacedDigit().weight(.black))
                        .foregroundStyle(BrandPalette.accent)
                }
                .padding(14)
                .background(BrandPalette.panel)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
        }
    }

    private var resultBreakdown: some View {
        MelCard {
            Text(L.s("Result language"))
                .font(.headline)
                .foregroundStyle(BrandPalette.text)

            ForEach(ThrowResult.allCases) { result in
                HStack {
                    Image(systemName: result.systemImage)
                        .foregroundStyle(result.tint)
                    Text(result.title)
                        .foregroundStyle(BrandPalette.secondaryText)
                    Spacer()
                    Text("\(store.resultCounts[result, default: 0])")
                        .font(.headline.monospacedDigit())
                        .foregroundStyle(BrandPalette.text)
                }
            }
        }
    }

    private var cultureFacts: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle(
                title: L.s("Why this product logic works"),
                detail: L.s("A few short reminders of the product direction we are protecting.")
            )

            ForEach(AppData.cultureFacts) { fact in
                MelCard {
                    Text(fact.title)
                        .font(.headline)
                        .foregroundStyle(BrandPalette.text)
                    Text(fact.detail)
                        .font(.subheadline)
                        .foregroundStyle(BrandPalette.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}
