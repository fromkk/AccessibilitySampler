// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
    /// 閉じる
    internal static let close = L10n.tr("Localizable", "close")
    /// 現在の時刻: %@
    internal static func currentDate(_ p1: Any) -> String {
        return L10n.tr("Localizable", "current_date", String(describing: p1))
    }
    /// フォーカス当たりますか？
    internal static let focusHere = L10n.tr("Localizable", "focus_here")
    /// スキ
    internal static let like = L10n.tr("Localizable", "like")
    /// モーダルだよ
    internal static let modal = L10n.tr("Localizable", "modal")
    /// 次へ
    internal static let next = L10n.tr("Localizable", "next")
    /// OK
    internal static let ok = L10n.tr("Localizable", "ok")
    /// ここをタップ
    internal static let tapHere = L10n.tr("Localizable", "tap_here")
    /// タップされました
    internal static let tapped = L10n.tr("Localizable", "tapped")
    /// アクセシビリティサンプラー
    internal static let title = L10n.tr("Localizable", "title")

    internal enum Root {
        /// ボタン(accessible)
        internal static let buttonAccessible = L10n.tr("Localizable", "root.button_accessible")
        /// ボタン(not accessible)
        internal static let buttonNotAccessible = L10n.tr(
            "Localizable", "root.button_not_accessible")
        /// 日付(accessible)
        internal static let dateAccessible = L10n.tr("Localizable", "root.date_accessible")
        /// 日付(not accessible)
        internal static let dateNotAccessible = L10n.tr("Localizable", "root.date_not_accessible")
        /// フォーカス(accessible)
        internal static let focusAccessible = L10n.tr("Localizable", "root.focus_accessible")
        /// フォーカス(not accessible)
        internal static let focusNotAccessible = L10n.tr("Localizable", "root.focus_not_accessible")
        /// 見出し(accessible)
        internal static let headlineAccessible = L10n.tr("Localizable", "root.headline_accessible")
        /// 見出し(not accessible)
        internal static let headlineNotAccessible = L10n.tr(
            "Localizable", "root.headline_not_accessible")
        /// モーダル(accessible)
        internal static let modalAccessible = L10n.tr("Localizable", "root.modal_accessible")
        /// モーダル(not accessible)
        internal static let modalNotAccessible = L10n.tr("Localizable", "root.modal_not_accessible")
        /// スイッチ(accessible)
        internal static let switchAccessible = L10n.tr("Localizable", "root.switch_accessible")
        /// スイッチ(not accessible)
        internal static let switchNotAccessible = L10n.tr(
            "Localizable", "root.switch_not_accessible")
        /// タグ入力(accessible)
        internal static let tagAccessible = L10n.tr("Localizable", "root.tag_accessible")
        /// タグ入力(not accessible)
        internal static let tagNotAccessible = L10n.tr("Localizable", "root.tag_not_accessible")
        /// タップ(accessible)
        internal static let tapAccessible = L10n.tr("Localizable", "root.tap_accessible")
        /// タップ(not accessible)
        internal static let tapNotAccessible = L10n.tr("Localizable", "root.tap_not_accessible")
    }

    internal enum Tag {
        /// 追加
        internal static let add = L10n.tr("Localizable", "tag.add")
        /// タグを入力
        internal static let placeholder = L10n.tr("Localizable", "tag.placeholder")
        internal enum Validation {
            /// 16文字以内で入力してください
            internal static let tooLong = L10n.tr("Localizable", "tag.validation.too_long")
            /// 半角英数字で入力してください
            internal static let unavailable = L10n.tr("Localizable", "tag.validation.unavailable")
        }
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
