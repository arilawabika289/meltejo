import Foundation
import SwiftUI

enum SurfaceMood: String, CaseIterable, Identifiable, Codable {
    case studio
    case dryClay
    case humidNight
    case festival

    var id: String { rawValue }

    var title: String {
        switch self {
        case .studio:
            return L.s("Studio")
        case .dryClay:
            return L.s("Dry Clay")
        case .humidNight:
            return L.s("Humid Night")
        case .festival:
            return L.s("Festival")
        }
    }

    var shortTitle: String {
        switch self {
        case .studio:
            return L.s("STD")
        case .dryClay:
            return L.s("DRY")
        case .humidNight:
            return L.s("NGT")
        case .festival:
            return L.s("FST")
        }
    }

    var note: String {
        switch self {
        case .studio:
            return L.s("Neutral conditions for clean form work.")
        case .dryClay:
            return L.s("Sharper landings and faster rebounds.")
        case .humidNight:
            return L.s("Softer clay rewards calm, balanced control.")
        case .festival:
            return L.s("High-energy crowd mode with pressure baked in.")
        }
    }

    var tuningBonus: Int {
        switch self {
        case .studio:
            return 0
        case .dryClay:
            return 4
        case .humidNight:
            return 8
        case .festival:
            return -2
        }
    }
}

enum ThrowResult: String, CaseIterable, Identifiable, Codable {
    case drift
    case mecha
    case mano
    case bocin
    case monona

    var id: String { rawValue }

    var title: String {
        switch self {
        case .drift:
            return L.s("Drift")
        case .mecha:
            return L.s("Mecha")
        case .mano:
            return L.s("Mano")
        case .bocin:
            return L.s("Bocin")
        case .monona:
            return L.s("Moñona")
        }
    }

    var systemImage: String {
        switch self {
        case .drift:
            return "wind"
        case .mecha:
            return "sparkle"
        case .mano:
            return "hand.point.up.left.fill"
        case .bocin:
            return "scope"
        case .monona:
            return "burst.fill"
        }
    }

    var points: Int {
        switch self {
        case .drift:
            return 0
        case .mecha:
            return 1
        case .mano:
            return 3
        case .bocin:
            return 6
        case .monona:
            return 9
        }
    }

    var note: String {
        switch self {
        case .drift:
            return L.s("The release wandered. Good for learning, not for impact.")
        case .mecha:
            return L.s("You touched the spark zone. Raw but alive.")
        case .mano:
            return L.s("A composed landing close to the ring.")
        case .bocin:
            return L.s("The premium center-ring hit.")
        case .monona:
            return L.s("The crown shot: ring plus explosive finish.")
        }
    }

    var tint: Color {
        switch self {
        case .drift:
            return BrandPalette.mutedText
        case .mecha:
            return BrandPalette.glow
        case .mano:
            return BrandPalette.text
        case .bocin:
            return BrandPalette.accent
        case .monona:
            return BrandPalette.success
        }
    }
}

struct ThrowProfile: Identifiable, Codable, Equatable {
    let id: UUID
    let power: Double
    let arc: Double
    let composure: Double
    let surface: SurfaceMood
    let result: ThrowResult
    let timestamp: Date

    init(
        id: UUID = UUID(),
        power: Double,
        arc: Double,
        composure: Double,
        surface: SurfaceMood,
        result: ThrowResult,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.power = power
        self.arc = arc
        self.composure = composure
        self.surface = surface
        self.result = result
        self.timestamp = timestamp
    }
}

enum ChallengeMetric: String, Codable {
    case totalThrows
    case scoringThrows
    case premiumHits
    case mononaHits
    case bestFlow
}

struct SessionChallenge: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let detail: String
    let metric: ChallengeMetric
    let goal: Int
    let reward: String
    let systemImage: String
}

struct FeatureCard: Identifiable {
    let id: String
    let title: String
    let detail: String
    let systemImage: String
}

struct AtlasArticle: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let imageName: String
    let readTime: String
    let sections: [AtlasSection]
}

struct CultureFact: Identifiable {
    let id: String
    let title: String
    let detail: String
}

struct AtlasSection: Identifiable {
    let id: String
    let title: String
    let body: String
}

struct SignatureMetric: Identifiable {
    let id: String
    let title: String
    let value: String
    let detail: String
}

struct OnboardingPage: Identifiable {
    let id: String
    let eyebrow: String
    let title: String
    let detail: String
}
