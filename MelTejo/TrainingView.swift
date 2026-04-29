import SwiftUI

struct TrainingView: View {
    @EnvironmentObject private var store: MelTejoStore

    @State private var aim = CGPoint(x: 0.50, y: 0.54)
    @State private var roundActive = false
    @State private var throwsRemaining = 6
    @State private var roundScore = 0
    @State private var landedShots: [LandedShot] = []
    @State private var shotSequence = 0
    @State private var currentDiscPosition = CGPoint(x: 0.50, y: 1.08)
    @State private var discVisible = false
    @State private var throwInFlight = false
    @State private var feedback = L.s("Shape a throw, aim, and start the round.")

    private let pegPoints: [CGPoint] = [
        CGPoint(x: 0.50, y: 0.17),
        CGPoint(x: 0.83, y: 0.50),
        CGPoint(x: 0.50, y: 0.83),
        CGPoint(x: 0.17, y: 0.50)
    ]

    var body: some View {
        MelScrollCanvas(title: L.s("Throw Lab")) {
            MelHeader(
                eyebrow: L.s("Throw Lab"),
                title: L.s("A full tejo game loop lives here now."),
                subtitle: L.s("Start a round, tap the board to place the aim, then press Throw. Everything important now stays in one visible block.")
            )

            gameStage
            surfaceSelector
            presets
            recentThrows
        }
    }

    private var gameStage: some View {
        MelCard {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(L.s("Round"))
                        .font(.headline)
                        .foregroundStyle(BrandPalette.text)
                    Text(roundActive ? L.s("Live tejo run") : L.s("Ready to start"))
                        .font(.subheadline)
                        .foregroundStyle(BrandPalette.secondaryText)
                }
                Spacer()
                HStack(spacing: 10) {
                    MetricPill(value: "\(roundScore)", label: L.s("score"))
                        .frame(width: 94)
                    MetricPill(value: "\(throwsRemaining)", label: L.s("left"))
                        .frame(width: 94)
                }
            }

            Text(L.s("1. Tap or drag on the board to move the aim.\n2. Adjust release controls below.\n3. Press Throw Disc."))
                .font(.subheadline)
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)

            boardPlayfield

            releaseBoard

            HStack(spacing: 12) {
                Button(roundActive ? L.s("Round live") : L.s("Start 6-throw round")) {
                    startRound()
                }
                .buttonStyle(.borderedProminent)
                .tint(BrandPalette.accent)
                .foregroundStyle(BrandPalette.ink)
                .disabled(roundActive)

                Button(L.s("Reset board")) {
                    resetBoard()
                }
                .buttonStyle(.bordered)
                .disabled(throwInFlight)
            }

            Text(feedback)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var boardPlayfield: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)

            ZStack {
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.26, green: 0.17, blue: 0.12), Color(red: 0.16, green: 0.11, blue: 0.08)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Circle()
                    .fill(Color(red: 0.67, green: 0.39, blue: 0.23))
                    .frame(width: size * 0.92, height: size * 0.92)

                Circle()
                    .stroke(BrandPalette.text.opacity(0.82), lineWidth: size * 0.05)
                    .frame(width: size * 0.92, height: size * 0.92)

                Circle()
                    .stroke(BrandPalette.text.opacity(0.35), lineWidth: 2)
                    .frame(width: size * 0.48, height: size * 0.48)

                Circle()
                    .stroke(BrandPalette.text.opacity(0.18), lineWidth: 2)
                    .frame(width: size * 0.72, height: size * 0.72)

                ForEach(Array(pegPoints.enumerated()), id: \.offset) { _, point in
                    Rectangle()
                        .fill(BrandPalette.accent)
                        .frame(width: size * 0.08, height: size * 0.08)
                        .position(x: point.x * size, y: point.y * size)
                }

                ForEach(landedShots) { shot in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [shot.result.tint.opacity(0.96), shot.result.tint.opacity(0.28)],
                                center: .center,
                                startRadius: 2,
                                endRadius: size * 0.06
                            )
                        )
                        .frame(width: size * 0.085, height: size * 0.085)
                        .position(x: shot.point.x * size, y: shot.point.y * size)
                        .overlay {
                            Circle()
                                .stroke(Color.white.opacity(0.30), lineWidth: 1.5)
                                .frame(width: size * 0.085, height: size * 0.085)
                                .position(x: shot.point.x * size, y: shot.point.y * size)
                        }
                }

                aimCursor(size: size)

                if discVisible {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.white, Color.gray.opacity(0.78), Color.black.opacity(0.92)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .overlay {
                            Circle()
                                .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        }
                        .frame(width: size * 0.11, height: size * 0.11)
                        .shadow(color: BrandPalette.ink.opacity(0.34), radius: 12, y: 8)
                        .position(x: currentDiscPosition.x * size, y: currentDiscPosition.y * size)
                }
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        guard !throwInFlight else { return }
                        aim = normalizedPoint(from: value.location, in: size)
                    }
            )
        }
        .frame(height: 300)
    }

    private var releaseBoard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(L.s("Release controls"))
                .font(.headline)
                .foregroundStyle(BrandPalette.text)

            sliderRow(L.s("Power"), value: $store.releasePower)
            sliderRow(L.s("Arc"), value: $store.releaseArc)
            sliderRow(L.s("Composure"), value: $store.releaseComposure)

            HStack {
                predictedChip(title: L.s("Predicted"), value: store.predictedResult.title, accent: store.predictedResult.tint)
                predictedChip(title: L.s("Mood"), value: store.selectedSurface.shortTitle, accent: BrandPalette.accent)
            }

            Button(L.s("Throw Disc")) {
                launchThrow()
            }
            .buttonStyle(.borderedProminent)
            .tint(roundActive ? BrandPalette.accent : BrandPalette.panelSoft)
            .foregroundStyle(roundActive ? BrandPalette.ink : BrandPalette.text)
            .disabled(!roundActive || throwInFlight || throwsRemaining == 0)
        }
    }

    private var surfaceSelector: some View {
        MelCard {
            Text(L.s("Surface mood"))
                .font(.headline)
                .foregroundStyle(BrandPalette.text)

            ForEach(SurfaceMood.allCases) { mood in
                Button {
                    store.selectedSurface = mood
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(mood.title)
                                .font(.headline)
                            Text(mood.note)
                                .font(.caption)
                                .foregroundStyle(BrandPalette.secondaryText)
                        }
                        Spacer()
                        if store.selectedSurface == mood {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(BrandPalette.accent)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .buttonStyle(.borderedProminent)
                .tint(store.selectedSurface == mood ? BrandPalette.panelSoft : BrandPalette.ink)
                .foregroundStyle(BrandPalette.text)
            }
        }
    }

    private var presets: some View {
        MelCard {
            Text(L.s("Studio presets"))
                .font(.headline)
                .foregroundStyle(BrandPalette.text)

            presetButton(
                title: L.s("Calm Technician"),
                note: L.s("Balanced, humid-night precision."),
                action: { store.applyStudioPreset(power: 65, arc: 63, composure: 81, surface: .humidNight) }
            )
            presetButton(
                title: L.s("Dry Clay Attack"),
                note: L.s("Sharper power with direct ring intent."),
                action: { store.applyStudioPreset(power: 72, arc: 58, composure: 70, surface: .dryClay) }
            )
            presetButton(
                title: L.s("Festival Heat"),
                note: L.s("Louder pace, less safety, more spectacle."),
                action: { store.applyStudioPreset(power: 77, arc: 60, composure: 61, surface: .festival) }
            )
        }
    }

    private var recentThrows: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle(
                title: L.s("Latest landed discs"),
                detail: L.s("Round throws are also written into your long-term signature profile.")
            )

            if store.throwLog.isEmpty {
                MelCard {
                    Text(L.s("No throws committed yet."))
                        .font(.headline)
                        .foregroundStyle(BrandPalette.text)
                    Text(L.s("Start a round and land your first disc."))
                        .font(.subheadline)
                        .foregroundStyle(BrandPalette.secondaryText)
                }
            } else {
                ForEach(store.throwLog.prefix(5)) { profile in
                    MelCard {
                        HStack {
                            Text(profile.result.title)
                                .font(.headline)
                                .foregroundStyle(profile.result.tint)
                            Spacer()
                            Text(profile.surface.shortTitle)
                                .font(.caption.weight(.bold))
                                .foregroundStyle(BrandPalette.accent)
                        }
                        Text(L.f("Power %d • Arc %d • Composure %d", Int(profile.power), Int(profile.arc), Int(profile.composure)))
                            .font(.subheadline)
                            .foregroundStyle(BrandPalette.secondaryText)
                    }
                }
            }
        }
    }

    private func startRound() {
        roundActive = true
        throwsRemaining = 6
        roundScore = 0
        landedShots = []
        shotSequence = 0
        feedback = L.s("Round live. Aim on the board and throw.")
        resetDiscPosition()
    }

    private func resetBoard() {
        roundActive = false
        throwsRemaining = 6
        roundScore = 0
        landedShots = []
        shotSequence = 0
        feedback = L.s("Board reset. Start a new round when ready.")
        resetDiscPosition()
    }

    private func launchThrow() {
        guard roundActive, !throwInFlight, throwsRemaining > 0 else { return }

        let landingPoint = resolvedLandingPoint()
        let result = resultForLanding(at: landingPoint)
        let impactFeedback = resultFeedback(result: result)

        throwInFlight = true
        discVisible = true
        currentDiscPosition = CGPoint(x: 0.50, y: 1.08)

        withAnimation(.easeIn(duration: 0.55)) {
            currentDiscPosition = landingPoint
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            shotSequence += 1
            landedShots.append(LandedShot(id: "shot-\(shotSequence)", point: landingPoint, result: result))
            landedShots = Array(landedShots.suffix(10))
            roundScore += result.points
            throwsRemaining -= 1
            store.commitThrow(
                result: result,
                power: store.releasePower,
                arc: store.releaseArc,
                composure: store.releaseComposure,
                surface: store.selectedSurface
            )
            feedback = impactFeedback

            withAnimation(.easeOut(duration: 0.35)) {
                discVisible = false
            }

            throwInFlight = false
            resetDiscPosition()

            if throwsRemaining == 0 {
                roundActive = false
                feedback = L.f("Round complete. Final score: %d.", roundScore)
            }
        }
    }

    private func resolvedLandingPoint() -> CGPoint {
        let composureSpread = (100 - store.releaseComposure) / 260
        let powerSpread = abs(store.releasePower - 68) / 550
        let arcSpread = abs(store.releaseArc - 62) / 620
        let surfaceSpread = spreadModifier(for: store.selectedSurface)
        let totalSpread = composureSpread + powerSpread + arcSpread + surfaceSpread

        let xOffset = Double.random(in: -totalSpread...totalSpread)
        let yOffset = Double.random(in: -totalSpread...totalSpread)

        return CGPoint(
            x: min(max(aim.x + xOffset, 0.14), 0.86),
            y: min(max(aim.y + yOffset, 0.14), 0.86)
        )
    }

    private func resultForLanding(at point: CGPoint) -> ThrowResult {
        let distance = hypot(point.x - 0.5, point.y - 0.5)
        let nearestPeg = pegPoints.map { hypot(point.x - $0.x, point.y - $0.y) }.min() ?? 1

        if distance < 0.08, nearestPeg < 0.14 {
            return .monona
        } else if distance < 0.08 {
            return .bocin
        } else if distance < 0.19 {
            return .mano
        } else if nearestPeg < 0.11 {
            return .mecha
        } else {
            return .drift
        }
    }

    private func resultFeedback(result: ThrowResult) -> String {
        switch result {
        case .drift:
            return L.s("Drift. The disc slipped wide.")
        case .mecha:
            return L.s("Mecha. You clipped the spark zone.")
        case .mano:
            return L.s("Mano. Clean control near the ring.")
        case .bocin:
            return L.s("Bocin. Premium center-ring contact.")
        case .monona:
            return L.s("Moñona. Crown shot landed.")
        }
    }

    private func resetDiscPosition() {
        currentDiscPosition = CGPoint(x: 0.50, y: 1.08)
    }

    private func normalizedPoint(from location: CGPoint, in size: CGFloat) -> CGPoint {
        CGPoint(
            x: min(max(location.x / size, 0.14), 0.86),
            y: min(max(location.y / size, 0.14), 0.86)
        )
    }

    private func spreadModifier(for mood: SurfaceMood) -> Double {
        switch mood {
        case .studio:
            return 0.02
        case .dryClay:
            return 0.03
        case .humidNight:
            return 0.025
        case .festival:
            return 0.05
        }
    }

    private func aimCursor(size: CGFloat) -> some View {
        ZStack {
                Circle()
                    .stroke(BrandPalette.glow.opacity(0.9), lineWidth: 2)
                    .frame(width: size * 0.09, height: size * 0.09)
            Rectangle()
                .fill(BrandPalette.glow)
                .frame(width: 2, height: size * 0.08)
            Rectangle()
                .fill(BrandPalette.glow)
                .frame(width: size * 0.08, height: 2)
        }
        .position(x: aim.x * size, y: aim.y * size)
        .shadow(color: BrandPalette.glow.opacity(0.4), radius: 8)
    }

    private func sliderRow(_ title: String, value: Binding<Double>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(BrandPalette.secondaryText)
                Spacer()
                Text("\(Int(value.wrappedValue))")
                    .font(.headline.monospacedDigit())
                    .foregroundStyle(BrandPalette.text)
            }
            Slider(value: value, in: 0...100)
                .tint(BrandPalette.accent)
        }
    }

    private func presetButton(title: String, note: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(note)
                    .font(.caption)
                    .foregroundStyle(BrandPalette.secondaryText)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .buttonStyle(.borderedProminent)
        .tint(BrandPalette.panelSoft)
        .foregroundStyle(BrandPalette.text)
    }

    private func predictedChip(title: String, value: String, accent: Color) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption.weight(.bold))
                .foregroundStyle(BrandPalette.secondaryText)
            Text(value)
                .font(.headline)
                .foregroundStyle(BrandPalette.text)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(accent.opacity(0.14))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

private struct LandedShot: Identifiable {
    let id: String
    let point: CGPoint
    let result: ThrowResult
}
