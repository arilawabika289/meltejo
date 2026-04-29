import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: MelTejoStore
    private let metrics = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]

    var body: some View {
        MelScrollCanvas(title: L.s("Studio")) {
            introBlock
            signatureSpotlightCard
            metricsGrid
            sessionMoodCard
            uniqueSectionCard
        }
    }

    private var introBlock: some View {
        MelCard {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 14) {
                    homeLogoBadge

                    VStack(alignment: .leading, spacing: 6) {
                        Text("MEL TEJO")
                            .font(.system(size: 15, weight: .black, design: .rounded))
                            .tracking(0.5)
                            .foregroundStyle(BrandPalette.accent)

                        Text(L.s("Throw Studio"))
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundStyle(BrandPalette.secondaryText)

                        Text(L.s("Studio ritual"))
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                            .foregroundStyle(BrandPalette.text)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(BrandPalette.panelSoft.opacity(0.75))
                            .clipShape(Capsule())
                    }

                    Spacer(minLength: 0)
                }

                Text(L.s("A premium throw studio for Colombia's most tactile sport."))
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .foregroundStyle(BrandPalette.text)
                    .lineSpacing(-1)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(L.s("Shape a release, build a night ritual, and discover your personal tejo signature."))
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(BrandPalette.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 10) {
                    introStatPill(title: L.s("Throw Lab"), detail: L.s("Power, arc, composure"))
                    introStatPill(title: L.s("Signature"), detail: L.s("Profile emerges over time"))
                }

                introHeroImage
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var introHeroImage: some View {
        ZStack(alignment: .bottomLeading) {
            Image("TejoHero")
                .resizable()
                .scaledToFill()
                .frame(height: 152)
                .frame(maxWidth: .infinity)
                .overlay {
                    LinearGradient(
                        colors: [
                            Color.black.opacity(0.02),
                            Color.black.opacity(0.12),
                            Color.black.opacity(0.42)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(L.s("Shape your release."))
                    .font(.system(size: 13, weight: .black, design: .rounded))
                    .foregroundStyle(BrandPalette.text)

                Text(L.s("Build your night before the first throw lands."))
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundStyle(BrandPalette.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(BrandPalette.ink.opacity(0.76))
            .overlay {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(BrandPalette.accent.opacity(0.22), lineWidth: 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(12)
        }
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(BrandPalette.accent.opacity(0.10), lineWidth: 1)
        }
    }

    private func introStatPill(title: String, detail: String) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(.system(size: 12, weight: .black, design: .rounded))
                .foregroundStyle(BrandPalette.text)

            Text(detail)
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(BrandPalette.panelSoft.opacity(0.42))
        )
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(BrandPalette.accent.opacity(0.08), lineWidth: 1)
        }
    }

    private var homeLogoBadge: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(BrandPalette.panel)

            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(BrandPalette.accent.opacity(0.10), lineWidth: 1)

            MelRing(segmentCount: 4, lineWidth: 3.5, trim: (0.06, 0.18))
                .frame(width: 38, height: 38)
                .foregroundStyle(BrandPalette.accent.opacity(0.14))

            BrandLogoImage()
                .frame(width: 28, height: 28)
        }
        .frame(width: 56, height: 56)
        .shadow(color: BrandPalette.ink.opacity(0.22), radius: 10, y: 6)
    }

    private var signatureSpotlightCard: some View {
        deckCard {
            Text(L.s("Signature"))
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(BrandPalette.text)

            HStack(alignment: .center, spacing: 18) {
                MelBadge(systemName: "waveform.path.ecg")
                    .frame(width: 96, height: 96)

                VStack(alignment: .leading, spacing: 8) {
                    Text(store.signatureTitle)
                        .font(.system(size: 24, weight: .black, design: .rounded))
                        .foregroundStyle(BrandPalette.text)
                        .lineSpacing(-1)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(store.signatureNote)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(BrandPalette.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(L.s("Profile reads your long-term rhythm, not just a single scoreline."))
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(BrandPalette.accent)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private var metricsGrid: some View {
        LazyVGrid(columns: metrics, spacing: 12) {
            deckMetricCard(value: "\(store.totalThrows)", label: L.s("throws"))
            deckMetricCard(value: "\(store.premiumHits)", label: L.s("premium"))
            deckMetricCard(value: "\(store.bestFlowStreak)", label: L.s("flow"))
            deckMetricCard(value: "\(Int(store.scoringAccuracy * 100))%", label: L.s("clean"))
        }
    }

    private var sessionMoodCard: some View {
        deckCard {
            Text(L.s("Tonight's active mood"))
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(BrandPalette.text)

            HStack(alignment: .center, spacing: 18) {
                MelBadge(systemName: "sparkles")
                    .frame(width: 96, height: 96)

                VStack(alignment: .leading, spacing: 8) {
                    Text(store.selectedSurface.title)
                        .font(.system(size: 24, weight: .black, design: .rounded))
                        .foregroundStyle(BrandPalette.text)
                        .lineSpacing(-1)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(store.selectedSurface.note)
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(BrandPalette.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)

                    Text(store.predictedResult.title)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(store.predictedResult.tint)
                }
            }
        }
    }

    private var uniqueSectionCard: some View {
        deckCard {
            Text(L.s("What makes this version unique"))
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(BrandPalette.text)

            Text(L.s("Mel Tejo is framed as a personal throw studio and session ritual app, not as a reskinned sports dashboard."))
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)

            VStack(spacing: 10) {
                ForEach(AppData.cards) { card in
                    MelFeatureRow(title: card.title, detail: card.detail, systemImage: card.systemImage)
                }
            }
        }
    }

    private func deckMetricCard(value: String, label: String) -> some View {
        VStack(spacing: 6) {
            Spacer(minLength: 0)

            Text(value)
                .font(.system(size: 26, weight: .black, design: .rounded))
                .foregroundStyle(BrandPalette.text)
                .lineLimit(1)
                .minimumScaleFactor(0.72)

            Text(label)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundStyle(BrandPalette.secondaryText)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.72)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(BrandPalette.panel)
        )
        .overlay(alignment: .topTrailing) {
            MelRing(segmentCount: 4, lineWidth: 5, trim: (0.05, 0.18))
                .frame(width: 54, height: 54)
                .foregroundStyle(BrandPalette.accent.opacity(0.16))
                .offset(x: 2, y: -2)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private func deckCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            content()
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(BrandPalette.panel)
        )
        .overlay(alignment: .bottomTrailing) {
            MelRing(segmentCount: 4, lineWidth: 5, trim: (0.05, 0.18))
                .frame(width: 72, height: 72)
                .foregroundStyle(BrandPalette.accent.opacity(0.08))
                .offset(x: 6, y: 8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}
