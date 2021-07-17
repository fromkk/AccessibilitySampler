// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
    /// スキ
    internal static let like = L10n.tr("Localizable", "like")
    /// ここをタップ
    internal static let tapHere = L10n.tr("Localizable", "tap_here")
    /// Accessibility Sampler
    internal static let title = L10n.tr("Localizable", "title")

    internal enum Root {
        /// ボタン(accessible)
        internal static let buttonAccessible = L10n.tr("Localizable", "root.button_accessible")
        /// ボタン(not accessible)
        internal static let buttonNotAccessible = L10n.tr(
            "Localizable", "root.button_not_accessible")
        /// タップ(accessible)
        internal static let tapAccessible = L10n.tr("Localizable", "root.tap_accessible")
        /// タップ(not accessible)
        internal static let tapNotAccessible = L10n.tr("Localizable", "root.tap_not_accessible")
    }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
            return Bundle.module
        #else
            return Bundle(for: BundleToken.self)
        #endif
    }()
}
// swiftlint:enable convenience_type
