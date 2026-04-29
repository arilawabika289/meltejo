import SwiftUI

struct MelScrollCanvas<Content: View>: View {
    let title: String?
    let horizontalPadding: CGFloat
    @ViewBuilder let content: Content

    init(
        title: String? = nil,
        horizontalPadding: CGFloat = 20,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.horizontalPadding = horizontalPadding
        self.content = content()
    }

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let contentWidth = max(geometry.size.width - (horizontalPadding * 2), 0)

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        content
                    }
                    .frame(width: contentWidth, alignment: .leading)
                    .padding(.horizontal, horizontalPadding)
                    .padding(.top, 20)
                    .padding(.bottom, 44)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .scrollIndicators(.hidden)
            .background(BrandPalette.background.ignoresSafeArea())
            .navigationTitle(title ?? "")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MelHeader: View {
    let eyebrow: String
    let title: String
    let subtitle: String
    var titleFont: Font = .largeTitle.weight(.black)
    var titleLineLimit: Int? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(eyebrow.uppercased())
                .font(.caption.weight(.black))
                .foregroundStyle(BrandPalette.accent)
            Text(title)
                .font(titleFont)
                .foregroundStyle(BrandPalette.text)
                .lineLimit(titleLineLimit)
                .fixedSize(horizontal: false, vertical: true)
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct MelFeatureRow: View {
    let title: String
    let detail: String
    let systemImage: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            MelBadge(systemName: systemImage)
                .frame(width: 56, height: 56)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(BrandPalette.text)

                Text(detail)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(BrandPalette.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 0)
        }
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MetricPill: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.weight(.black))
                .foregroundStyle(BrandPalette.text)
            Text(label)
                .font(.caption.weight(.bold))
                .foregroundStyle(BrandPalette.secondaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(BrandPalette.panel)
        .overlay(alignment: .topTrailing) {
            MelRing(segmentCount: 5, lineWidth: 4, trim: (0.06, 0.20))
                .frame(width: 48, height: 48)
                .foregroundStyle(BrandPalette.accent.opacity(0.18))
                .offset(x: 10, y: -8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct SectionTitle: View {
    let title: String
    let detail: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title3.weight(.bold))
                .foregroundStyle(BrandPalette.text)
            Text(detail)
                .font(.subheadline)
                .foregroundStyle(BrandPalette.secondaryText)
        }
    }
}

struct MelCard<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            content
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(BrandPalette.panel)
        .overlay(alignment: .bottomTrailing) {
            MelRing(segmentCount: 4, lineWidth: 5, trim: (0.04, 0.16))
                .frame(width: 72, height: 72)
                .foregroundStyle(BrandPalette.accent.opacity(0.10))
                .offset(x: 14, y: 18)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

struct MelMark: View {
    var size: CGFloat = 176

    var body: some View {
        ZStack {
            MelRing(segmentCount: 6, lineWidth: size * 0.05, trim: (0.06, 0.18))
                .frame(width: size, height: size)
                .foregroundStyle(BrandPalette.accent)

            BrandLogoImage()
                .frame(width: size * 0.82, height: size * 0.82)
        }
    }
}

struct BrandLogoImage: View {
    var body: some View {
        Image("MelLogo")
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }
}

struct MelBadge: View {
    let systemName: String

    var body: some View {
        ZStack {
            MelRing(segmentCount: 6, lineWidth: 4, trim: (0.06, 0.18))
                .foregroundStyle(BrandPalette.accent.opacity(0.30))

            Circle()
                .fill(BrandPalette.accent.opacity(0.10))
                .padding(12)

            Image(systemName: systemName)
                .font(.headline.weight(.black))
                .foregroundStyle(BrandPalette.accent)
        }
        .frame(width: 54, height: 54)
    }
}

struct MelSideBadge: View {
    let title: String
    let accent: Color

    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(accent)
                .frame(width: 14, height: 14)
            Text(title)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(BrandPalette.text)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(accent.opacity(0.18))
        .clipShape(Capsule())
    }
}

struct MelRing: View {
    let segmentCount: Int
    let lineWidth: CGFloat
    let trim: (CGFloat, CGFloat)

    var body: some View {
        ZStack {
            ForEach(0..<segmentCount, id: \.self) { index in
                Circle()
                    .trim(from: trim.0, to: trim.1)
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .rotationEffect(.degrees(Double(index) * (360 / Double(segmentCount))))
            }

            Circle()
                .stroke(style: StrokeStyle(lineWidth: lineWidth * 0.9))
                .padding(lineWidth * 2.4)
        }
    }
}
