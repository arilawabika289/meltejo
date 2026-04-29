import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case spanish = "es"

    static let storageKey = "meltejo.app.language"

    var id: String { rawValue }

    var locale: Locale {
        Locale(identifier: rawValue)
    }

    var displayName: String {
        switch self {
        case .english:
            return "English"
        case .spanish:
            return "Español"
        }
    }

    static var current: AppLanguage {
        if let stored = UserDefaults.standard.string(forKey: storageKey),
           let language = AppLanguage(rawValue: stored) {
            return language
        }

        let preferredCode = Locale.preferredLanguages.first?.lowercased() ?? "en"
        return preferredCode.hasPrefix("es") ? .spanish : .english
    }
}

enum L {
    static func s(_ key: String) -> String {
        bundle.localizedString(forKey: key, value: key, table: nil)
    }

    static func f(_ key: String, _ args: CVarArg...) -> String {
        String(format: s(key), locale: AppLanguage.current.locale, arguments: args)
    }

    private static var bundle: Bundle {
        let language = AppLanguage.current

        if let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return bundle
        }

        return Bundle.main
    }
}
