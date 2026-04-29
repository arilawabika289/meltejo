import SwiftUI

struct ExploreView: View {
    var body: some View {
        MelScrollCanvas(title: L.s("Atlas")) {
            MelHeader(
                eyebrow: L.s("Atlas"),
                title: L.s("A lighter cultural map around tejo, not a generic directory tab."),
                subtitle: L.s("This screen keeps the sport rooted in Colombia and gives Mel Tejo more weight than a pure game shell.")
            )

            cultureIntro
            articles
            closingCard
        }
    }

    private var cultureIntro: some View {
        MelCard {
            Text(L.s("Why atlas mode exists"))
                .font(.headline)
                .foregroundStyle(BrandPalette.text)
            Text(L.s("Tejo has a sensory and cultural identity that deserves more than a hidden help screen. Atlas mode now keeps that identity inside the app through original reading cards, internal explainers, and visual essays."))
                .font(.subheadline)
                .foregroundStyle(BrandPalette.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var articles: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle(
                title: L.s("Internal atlas articles"),
                detail: L.s("Short in-app reading pieces that explain the sport, the throw logic, and the ritual idea behind Mel Tejo.")
            )

            ForEach(AppData.atlasArticles) { article in
                NavigationLink {
                    AtlasArticleView(article: article)
                } label: {
                    MelCard {
                        Image(article.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 180)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                        Text(article.title)
                            .font(.headline)
                            .foregroundStyle(BrandPalette.text)
                        Text(article.readTime)
                            .font(.caption.weight(.bold))
                            .foregroundStyle(BrandPalette.accent)
                        Text(article.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(BrandPalette.secondaryText)
                        Text(L.s("Read article"))
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(BrandPalette.accent)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var closingCard: some View {
        MelCard {
            Text(L.s("Design principle"))
                .font(.headline)
                .foregroundStyle(BrandPalette.text)
            Text(L.s("If Mel Tejo ever feels like it could be swapped onto another random sport, it is not specific enough. Atlas mode protects against that."))
                .font(.subheadline)
                .foregroundStyle(BrandPalette.secondaryText)
        }
    }
}

private struct AtlasArticleView: View {
    let article: AtlasArticle

    var body: some View {
        MelScrollCanvas(title: article.title) {
            Image(article.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))

            MelCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text(article.title)
                        .font(.title2.weight(.black))
                        .foregroundStyle(BrandPalette.text)
                        .multilineTextAlignment(.leading)
                    Text(article.readTime)
                        .font(.caption.weight(.bold))
                        .foregroundStyle(BrandPalette.accent)
                    Text(article.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(BrandPalette.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            ForEach(article.sections) { section in
                MelCard {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(section.title)
                            .font(.headline)
                            .foregroundStyle(BrandPalette.text)
                            .multilineTextAlignment(.leading)
                        Text(section.body)
                            .font(.subheadline)
                            .foregroundStyle(BrandPalette.secondaryText)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
