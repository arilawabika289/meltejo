import SwiftUI

struct MatchCenterView: View {
    @EnvironmentObject private var store: MelTejoStore

    var body: some View {
        MelScrollCanvas(title: L.s("Session Deck")) {
            MelHeader(
                eyebrow: L.s("Session Deck"),
                title: L.s("Turn a night of tejo into a ritual instead of a plain scorekeeping session."),
                subtitle: L.s("Pick a challenge card, understand the goal, and use Throw Lab to build toward a more intentional session story.")
            )

            activeChallenge
            progressStrip
            progressExplain
            challengeGrid
            ritualNote
        }
    }

    private var activeChallenge: some View {
        MelCard {
            Text(L.s("Active card"))
                .font(.headline)
                .foregroundStyle(BrandPalette.text)

            if let challenge = store.activeChallenge {
                HStack(alignment: .top, spacing: 12) {
                    MelBadge(systemName: challenge.systemImage)
                    VStack(alignment: .leading, spacing: 6) {
                        Text(challenge.title)
                            .font(.title3.weight(.black))
                            .foregroundStyle(BrandPalette.text)
                        Text(challenge.detail)
                            .font(.subheadline)
                            .foregroundStyle(BrandPalette.secondaryText)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(L.f("Reward: %@", challenge.reward))
                            .font(.caption.weight(.bold))
                            .foregroundStyle(BrandPalette.accent)
                    }
                }
            }
        }
    }

    private var progressStrip: some View {
        HStack(spacing: 12) {
            MetricPill(value: "\(store.totalThrows)", label: L.s("throws"))
            MetricPill(value: "\(store.premiumHits)", label: L.s("premium"))
            MetricPill(value: "\(store.mononaHits)", label: L.s("moñona"))
            MetricPill(value: "\(store.bestFlowStreak)", label: L.s("flow"))
        }
    }

    private var challengeGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle(
                title: L.s("Choose the night's ritual"),
                detail: L.s("These cards push the session toward mood, discipline, or spectacle instead of generic competition.")
            )

            ForEach(AppData.challenges) { challenge in
                let progress = store.challengeProgress(for: challenge)
                let completed = store.completedChallenges.contains(challenge.id)

                Button {
                    store.activateChallenge(challenge)
                } label: {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(challenge.title)
                                .font(.headline)
                            Spacer()
                            if completed {
                                Text(L.s("Completed"))
                                    .font(.caption.weight(.bold))
                                    .foregroundStyle(BrandPalette.success)
                            }
                        }
                        Text(challenge.detail)
                            .font(.subheadline)
                            .foregroundStyle(BrandPalette.secondaryText)
                            .multilineTextAlignment(.leading)
                        Text(metricDescription(for: challenge))
                            .font(.caption)
                            .foregroundStyle(BrandPalette.mutedText)
                        ProgressView(value: Double(min(progress, challenge.goal)), total: Double(challenge.goal))
                            .tint(BrandPalette.accent)
                        Text(L.f("Progress %d/%d", min(progress, challenge.goal), challenge.goal))
                            .font(.caption.weight(.bold))
                            .foregroundStyle(BrandPalette.accent)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
                }
                .buttonStyle(.borderedProminent)
                .tint(store.activeChallengeID == challenge.id ? BrandPalette.panelSoft : BrandPalette.ink)
                .foregroundStyle(BrandPalette.text)
            }
        }
    }

    private var ritualNote: some View {
        MelCard {
            Text(L.s("How to use this screen"))
                .font(.headline)
                .foregroundStyle(BrandPalette.text)
            Text(L.s("Start here, pick one card, then move to Throw Lab and shape throws that fit the night. Session Deck reads the stats created by your real throws, so the story of the night is built through play, not by tapping progress manually."))
                .font(.subheadline)
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var progressExplain: some View {
        MelCard {
            Text(L.s("How progress works"))
                .font(.headline)
                .foregroundStyle(BrandPalette.text)

            VStack(alignment: .leading, spacing: 8) {
                Text(L.s("1. Choose a ritual card here in Session Deck."))
                Text(L.s("2. Go to Throw Lab and make real throws."))
                Text(L.s("3. Every throw updates live stats like premium hits, moñona, and flow."))
                Text(L.s("4. The selected card completes when its watched metric reaches the goal."))
            }
            .font(.subheadline)
            .foregroundStyle(BrandPalette.secondaryText)
            .frame(maxWidth: .infinity, alignment: .leading)

            if let challenge = store.activeChallenge {
                let progress = store.challengeProgress(for: challenge)
                Text(L.f("Active now: %@ is watching %@ and is currently at %d/%d.", challenge.title, metricTitle(for: challenge.metric).lowercased(), min(progress, challenge.goal), challenge.goal))
                    .font(.caption.weight(.bold))
                    .foregroundStyle(BrandPalette.accent)
            }
        }
    }

    private func metricTitle(for metric: ChallengeMetric) -> String {
        switch metric {
        case .totalThrows:
            return L.s("Total Throws")
        case .scoringThrows:
            return L.s("Scoring Throws")
        case .premiumHits:
            return L.s("Premium Hits")
        case .mononaHits:
            return L.s("Moñona Hits")
        case .bestFlow:
            return L.s("Best Flow Streak")
        }
    }

    private func metricDescription(for challenge: SessionChallenge) -> String {
        switch challenge.metric {
        case .totalThrows:
            return L.s("Counts every completed throw from Throw Lab.")
        case .scoringThrows:
            return L.s("Counts throws that land better than Drift.")
        case .premiumHits:
            return L.s("Counts only Bocin and Moñona results.")
        case .mononaHits:
            return L.s("Counts only Moñona crown shots.")
        case .bestFlow:
            return L.s("Counts your longest scoring streak without a Drift reset.")
        }
    }
}
