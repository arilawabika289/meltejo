import SwiftUI

struct OnboardingView: View {
    let onFinish: () -> Void
    @State private var page = 0

    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                MelRing(segmentCount: 6, lineWidth: 8, trim: (0.06, 0.18))
                    .frame(width: 196, height: 196)
                    .foregroundStyle(BrandPalette.accent.opacity(0.24))

                MelMark(size: 180)
                    .frame(width: 180, height: 180)
            }

            TabView(selection: $page) {
                ForEach(Array(AppData.onboardingPages.enumerated()), id: \.element.id) { index, item in
                    VStack(spacing: 12) {
                        Text(item.eyebrow)
                            .font(.caption.weight(.black))
                            .foregroundStyle(BrandPalette.accent)
                        Text(item.title)
                            .font(.title.weight(.black))
                            .foregroundStyle(BrandPalette.text)
                            .multilineTextAlignment(.center)
                        Text(item.detail)
                            .font(.body)
                            .foregroundStyle(BrandPalette.secondaryText)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .tag(index)
                    .padding(.horizontal, 24)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 230)

            Button(page == AppData.onboardingPages.count - 1 ? L.s("Enter Mel Tejo") : L.s("Continue")) {
                if page == AppData.onboardingPages.count - 1 {
                    onFinish()
                } else {
                    withAnimation(.easeInOut) {
                        page += 1
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(BrandPalette.accent)
            .foregroundStyle(BrandPalette.ink)

            Button(L.s("Skip")) {
                onFinish()
            }
            .foregroundStyle(BrandPalette.secondaryText)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BrandPalette.background.ignoresSafeArea())
    }
}
