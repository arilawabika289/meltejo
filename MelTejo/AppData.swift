import Foundation

enum AppData {
    static var cards: [FeatureCard] {
        [
        FeatureCard(
            id: "throw-studio",
            title: L.s("Throw Studio"),
            detail: L.s("Instead of a generic arcade mode, Mel Tejo lets the player sculpt a throw through power, arc, composure, and surface mood."),
            systemImage: "dial.high.fill"
        ),
        FeatureCard(
            id: "session-deck",
            title: L.s("Session Deck"),
            detail: L.s("Each night can be shaped around a different ritual: premium hits, calm flow, or crowd-pressure precision."),
            systemImage: "rectangle.stack.badge.play.fill"
        ),
        FeatureCard(
            id: "signature-profile",
            title: L.s("Signature Profile"),
            detail: L.s("The app identifies the kind of tejo player you are becoming, rather than only counting points and wins."),
            systemImage: "waveform.path.ecg.rectangle.fill"
        ),
        FeatureCard(
            id: "cultural-weight",
            title: L.s("Cultural Weight"),
            detail: L.s("Mel Tejo keeps the sport grounded in Colombia instead of abstracting it into another anonymous throwing game."),
            systemImage: "globe.americas.fill"
        )
    ]
    }

    static var challenges: [SessionChallenge] {
        [
        SessionChallenge(
            id: "gold-spark",
            title: L.s("Gold Spark"),
            detail: L.s("Open the night with two premium hits to set tone and confidence."),
            metric: .premiumHits,
            goal: 2,
            reward: L.s("Unlock a premium-start session badge."),
            systemImage: "sparkles.rectangle.stack.fill"
        ),
        SessionChallenge(
            id: "silent-precision",
            title: L.s("Silent Precision"),
            detail: L.s("Build five scoring throws in a row with calm release mechanics."),
            metric: .bestFlow,
            goal: 5,
            reward: L.s("Unlock the Silent Precision signature card."),
            systemImage: "moon.stars.fill"
        ),
        SessionChallenge(
            id: "ring-hunter",
            title: L.s("Ring Hunter"),
            detail: L.s("Chase three bocin-or-better throws before the session ends."),
            metric: .premiumHits,
            goal: 3,
            reward: L.s("Unlock the Ring Hunter session accent."),
            systemImage: "scope"
        ),
        SessionChallenge(
            id: "festival-finish",
            title: L.s("Festival Finish"),
            detail: L.s("Land one moñona under pressure and own the room."),
            metric: .mononaHits,
            goal: 1,
            reward: L.s("Unlock the Festival Finish ritual card."),
            systemImage: "party.popper.fill"
        )
    ]
    }

    static var atlasArticles: [AtlasArticle] {
        [
        AtlasArticle(
            id: "roots-of-tejo",
            title: L.s("Roots of Tejo"),
            subtitle: L.s("Why this Colombian sport feels heavy, ritualistic, and unlike a generic target game."),
            imageName: "TejoHero",
            readTime: L.s("3 min read"),
            sections: [
                AtlasSection(
                    id: "impact",
                    title: L.s("A sport built around impact"),
                    body: L.s("Tejo is not about soft accuracy alone. It is a tactile throwing sport built around clay, metal, distance, and the emotional build-up before contact. That makes it feel more physical and ceremonial than many mobile-friendly sports concepts.")
                ),
                AtlasSection(
                    id: "colombia",
                    title: L.s("Why Colombia matters here"),
                    body: L.s("Mel Tejo keeps the sport anchored in Colombia because that context gives the game its identity. Without that cultural grounding, tejo would risk feeling like just another abstract disc-throwing mechanic.")
                ),
                AtlasSection(
                    id: "premium-tone",
                    title: L.s("Why Mel uses a premium tone"),
                    body: L.s("The app translates the weight of clay and steel into a premium visual language. The goal is not to turn tejo into something luxurious for its own sake, but to respect the drama, pressure, and sensory presence that already exist inside the sport.")
                )
            ]
        ),
        AtlasArticle(
            id: "how-a-throw-works",
            title: L.s("How a Throw Works"),
            subtitle: L.s("A quick internal guide to the logic behind power, arc, composure, and premium hits in Mel Tejo."),
            imageName: "ClayBoard",
            readTime: L.s("2 min read"),
            sections: [
                AtlasSection(
                    id: "power",
                    title: L.s("Power"),
                    body: L.s("Power shapes whether the disc arrives with enough intent to threaten the ring instead of fading out. Too little and the throw drifts. Too much and the release can feel rushed unless the rest of the motion is balanced.")
                ),
                AtlasSection(
                    id: "arc-composure",
                    title: L.s("Arc and composure"),
                    body: L.s("Arc changes the feeling of the landing, while composure represents how controlled the release is under pressure. In Mel Tejo, premium results come from balance. The cleanest throws happen when force, shape, and calm all align.")
                ),
                AtlasSection(
                    id: "reading-results",
                    title: L.s("Reading the results"),
                    body: L.s("Drift means the throw never really took shape. Mecha and mano show progress and control. Bocin is the premium center-ring hit, while moñona is the crown result that marks a decisive, high-pressure finish.")
                )
            ]
        ),
        AtlasArticle(
            id: "session-rituals",
            title: L.s("Session Rituals"),
            subtitle: L.s("What the Session Deck is actually tracking, and how a night of throws turns into a story."),
            imageName: "Field",
            readTime: L.s("2 min read"),
            sections: [
                AtlasSection(
                    id: "throw-lab-progress",
                    title: L.s("Progress comes from Throw Lab"),
                    body: L.s("Session Deck does not advance on its own. It listens to what you do inside Throw Lab. Every completed throw updates your live stats, and those stats feed the active ritual card.")
                ),
                AtlasSection(
                    id: "card-metrics",
                    title: L.s("Each card watches a different metric"),
                    body: L.s("Some cards track premium hits, some watch for a moñona, and others care about flow. Flow means consecutive scoring throws without a drift breaking the streak. This makes each card feel like a different kind of night, not just a different score target.")
                ),
                AtlasSection(
                    id: "why-session-deck-exists",
                    title: L.s("Why this exists"),
                    body: L.s("The point of Session Deck is to frame a session with intention. Instead of opening the app and throwing randomly, you choose a mood for the night: confidence, precision, spectacle, or consistency.")
                )
            ]
        )
    ]
    }

    static var cultureFacts: [CultureFact] {
        [
        CultureFact(
            id: "why-different",
            title: L.s("Why Mel Tejo is different"),
            detail: L.s("The product is designed as a throw studio and session ritual tool, not as a cloned scoreboard with a new coat of paint.")
        ),
        CultureFact(
            id: "tejo-special",
            title: L.s("What makes tejo special"),
            detail: L.s("Few sports combine clay, metal, pressure, ritual, and impact the way tejo does. That sensory identity should shape the app.")
        ),
        CultureFact(
            id: "palette",
            title: L.s("Why the premium palette works"),
            detail: L.s("Black, steel, and gold-yellow give the sport a sharper premium edge without disconnecting it from the physical weight of the board and ring.")
        )
    ]
    }

    static var onboardingPages: [OnboardingPage] {
        [
            OnboardingPage(
                id: "identity",
                eyebrow: "MEL TEJO",
                title: L.s("Not a reskinned sports app."),
                detail: L.s("This product is built as a tejo-native experience: tactile, premium, and focused on how a throw feels, not just on generic game loops.")
            ),
            OnboardingPage(
                id: "throw-lab",
                eyebrow: "THROW LAB",
                title: L.s("Shape your release."),
                detail: L.s("Power, arc, composure, and surface mood create a predicted result and slowly reveal your personal signature.")
            ),
            OnboardingPage(
                id: "session-deck",
                eyebrow: "SESSION DECK",
                title: L.s("Author the night."),
                detail: L.s("Pick a ritual card, chase a session goal, and make each tejo evening feel distinct.")
            )
        ]
    }
}

@MainActor
final class MelTejoStore: ObservableObject {
    @Published var releasePower: Double = 66 { didSet { save() } }
    @Published var releaseArc: Double = 62 { didSet { save() } }
    @Published var releaseComposure: Double = 74 { didSet { save() } }
    @Published var selectedSurface: SurfaceMood = .humidNight { didSet { save() } }

    @Published var throwLog: [ThrowProfile] = [] { didSet { save() } }
    @Published var totalThrows = 0 { didSet { save() } }
    @Published var scoringThrows = 0 { didSet { save() } }
    @Published var premiumHits = 0 { didSet { save() } }
    @Published var mononaHits = 0 { didSet { save() } }
    @Published var currentFlowStreak = 0 { didSet { save() } }
    @Published var bestFlowStreak = 0 { didSet { save() } }
    @Published var resultCounts: [ThrowResult: Int] = Dictionary(uniqueKeysWithValues: ThrowResult.allCases.map { ($0, 0) }) { didSet { save() } }
    @Published var activeChallengeID: String = AppData.challenges.first?.id ?? "" { didSet { save() } }
    @Published var completedChallenges: [String] = [] { didSet { save() } }

    private let storageKey = "mel.tejo.unique.state"

    var predictedResult: ThrowResult {
        let delta = abs(releasePower - 66) + abs(releaseArc - 62) + abs(releaseComposure - 74)
        let controlScore = ((releasePower * 0.30) + (releaseArc * 0.26) + (releaseComposure * 0.34)) / 0.90
        let tunedScore = controlScore + Double(selectedSurface.tuningBonus)

        if delta < 10, tunedScore >= 81 {
            return .monona
        } else if delta < 18, tunedScore >= 72 {
            return .bocin
        } else if delta < 26, tunedScore >= 60 {
            return .mano
        } else if releasePower >= 48 {
            return .mecha
        } else {
            return .drift
        }
    }

    var signatureTitle: String {
        guard totalThrows > 0 else { return L.s("Unwritten Signature") }

        if mononaHits >= max(1, totalThrows / 6) {
            return L.s("Crown Chaser")
        } else if premiumHits >= max(2, totalThrows / 4) {
            return L.s("Ring Hunter")
        } else if bestFlowStreak >= 5 {
            return L.s("Calm Architect")
        } else if averageComposure >= 72 {
            return L.s("Night Technician")
        } else {
            return L.s("Raw Spark")
        }
    }

    var signatureNote: String {
        switch signatureTitle {
        case L.s("Crown Chaser"):
            return L.s("You hunt decisive, premium contact and accept risk for brilliance.")
        case L.s("Ring Hunter"):
            return L.s("Your release profile leans toward precision and repeatable center pressure.")
        case L.s("Calm Architect"):
            return L.s("You build flow and control instead of forcing highlight shots.")
        case L.s("Night Technician"):
            return L.s("You thrive when conditions ask for nerve, patience, and exact balance.")
        default:
            return L.s("Your profile is still emerging, but the spark is already there.")
        }
    }

    var scoringAccuracy: Double {
        guard totalThrows > 0 else { return 0 }
        return Double(scoringThrows) / Double(totalThrows)
    }

    var premiumRate: Double {
        guard totalThrows > 0 else { return 0 }
        return Double(premiumHits) / Double(totalThrows)
    }

    var averagePower: Double {
        average(\.power)
    }

    var averageArc: Double {
        average(\.arc)
    }

    var averageComposure: Double {
        average(\.composure)
    }

    var activeChallenge: SessionChallenge? {
        AppData.challenges.first(where: { $0.id == activeChallengeID })
    }

    func activateChallenge(_ challenge: SessionChallenge) {
        activeChallengeID = challenge.id
    }

    func challengeProgress(for challenge: SessionChallenge) -> Int {
        switch challenge.metric {
        case .totalThrows:
            return totalThrows
        case .scoringThrows:
            return scoringThrows
        case .premiumHits:
            return premiumHits
        case .mononaHits:
            return mononaHits
        case .bestFlow:
            return bestFlowStreak
        }
    }

    func commitThrow() {
        commitThrow(
            result: predictedResult,
            power: releasePower,
            arc: releaseArc,
            composure: releaseComposure,
            surface: selectedSurface
        )
    }

    func commitThrow(
        result: ThrowResult,
        power: Double,
        arc: Double,
        composure: Double,
        surface: SurfaceMood
    ) {
        let profile = ThrowProfile(
            power: power,
            arc: arc,
            composure: composure,
            surface: surface,
            result: result
        )

        throwLog.insert(profile, at: 0)
        throwLog = Array(throwLog.prefix(18))
        totalThrows += 1
        resultCounts[result, default: 0] += 1

        if result != .drift {
            scoringThrows += 1
            currentFlowStreak += 1
            bestFlowStreak = max(bestFlowStreak, currentFlowStreak)
        } else {
            currentFlowStreak = 0
        }

        if result == .bocin || result == .monona {
            premiumHits += 1
        }

        if result == .monona {
            mononaHits += 1
        }

        updateCompletedChallenges()
    }

    func applyStudioPreset(power: Double, arc: Double, composure: Double, surface: SurfaceMood) {
        releasePower = power
        releaseArc = arc
        releaseComposure = composure
        selectedSurface = surface
    }

    func clearAllStats() {
        throwLog = []
        totalThrows = 0
        scoringThrows = 0
        premiumHits = 0
        mononaHits = 0
        currentFlowStreak = 0
        bestFlowStreak = 0
        resultCounts = Dictionary(uniqueKeysWithValues: ThrowResult.allCases.map { ($0, 0) })
        completedChallenges = []
        activeChallengeID = AppData.challenges.first?.id ?? ""
    }

    private func updateCompletedChallenges() {
        for challenge in AppData.challenges {
            guard !completedChallenges.contains(challenge.id) else { continue }
            if challengeProgress(for: challenge) >= challenge.goal {
                completedChallenges.append(challenge.id)
            }
        }
    }

    private func average(_ keyPath: KeyPath<ThrowProfile, Double>) -> Double {
        guard !throwLog.isEmpty else { return 0 }
        let total = throwLog.reduce(0) { $0 + $1[keyPath: keyPath] }
        return total / Double(throwLog.count)
    }

    private func save() {
        let snapshot = MelTejoSnapshot(
            releasePower: releasePower,
            releaseArc: releaseArc,
            releaseComposure: releaseComposure,
            selectedSurface: selectedSurface,
            throwLog: throwLog,
            totalThrows: totalThrows,
            scoringThrows: scoringThrows,
            premiumHits: premiumHits,
            mononaHits: mononaHits,
            currentFlowStreak: currentFlowStreak,
            bestFlowStreak: bestFlowStreak,
            resultCounts: Dictionary(uniqueKeysWithValues: resultCounts.map { ($0.key.rawValue, $0.value) }),
            activeChallengeID: activeChallengeID,
            completedChallenges: completedChallenges
        )

        guard let data = try? JSONEncoder().encode(snapshot) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let snapshot = try? JSONDecoder().decode(MelTejoSnapshot.self, from: data) else {
            return
        }

        releasePower = snapshot.releasePower
        releaseArc = snapshot.releaseArc
        releaseComposure = snapshot.releaseComposure
        selectedSurface = snapshot.selectedSurface
        throwLog = snapshot.throwLog
        totalThrows = snapshot.totalThrows
        scoringThrows = snapshot.scoringThrows
        premiumHits = snapshot.premiumHits
        mononaHits = snapshot.mononaHits
        currentFlowStreak = snapshot.currentFlowStreak
        bestFlowStreak = snapshot.bestFlowStreak
        resultCounts = Dictionary(uniqueKeysWithValues: ThrowResult.allCases.map { ($0, snapshot.resultCounts[$0.rawValue] ?? 0) })
        activeChallengeID = snapshot.activeChallengeID
        completedChallenges = snapshot.completedChallenges
    }
}

private struct MelTejoSnapshot: Codable {
    let releasePower: Double
    let releaseArc: Double
    let releaseComposure: Double
    let selectedSurface: SurfaceMood
    let throwLog: [ThrowProfile]
    let totalThrows: Int
    let scoringThrows: Int
    let premiumHits: Int
    let mononaHits: Int
    let currentFlowStreak: Int
    let bestFlowStreak: Int
    let resultCounts: [String: Int]
    let activeChallengeID: String
    let completedChallenges: [String]
}
