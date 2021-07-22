//
//  HeadlineAccessibleViewController.swift
//  AccessibilitySampler
//
//  Created by Kazuya Ueoka on 2021/07/22.
//

import UIKit

final class HeadlineAccessibleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Root.headlineAccessible
        view.backgroundColor = UIColor.systemBackground
        addScrollView()
        addStackView()
        showTexts()
    }

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.accessibilityIdentifier = #function
        return scrollView
    }()

    private func addScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: view.bounds)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.accessibilityIdentifier = #function
        return stackView
    }()

    private func addStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            scrollView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
        ])
    }

    private func makeHeadlineLabel(with title: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = UIColor.label
        label.text = title
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.accessibilityTraits = [.header]
        return label
    }

    private func makeTextLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.label
        label.text = text
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }

    private func showTexts() {
        sections.forEach {
            stackView.addArrangedSubview(makeHeadlineLabel(with: $0.title))
            $0.texts.forEach {
                stackView.addArrangedSubview(makeTextLabel(with: $0))
            }
        }
    }

    struct Section {
        let title: String
        let texts: [String]
    }
    let sections: [Section] = [
        Section(
            title: "ヨレヨレのTシャツをファブリックパネルにしてみた",
            texts: [
                "2年前ぐらいにAltConfに参加するついでにCupertinoのApple Storeで購入したお気に入りのTシャツがあったのですが、着過ぎて首元がヨレヨレになってしまいました。",
                "マンションを購入して引っ越しを見据えていく中だったので、着古した服などは断捨離している最中なのですが、さすがにこれはもったいないなと思って悩んでいるところ、妻から「ファブリックパネルにすればいいじゃん」とアドバイスを貰って「それはいいな！」と思ったので実行してみました。",
            ]),
        Section(
            title: "購入したもの",
            texts: [
                "Amazonでタッカーとパネル本体、水テープを購入しました。"
            ]),
        Section(
            title: "作ってみる",
            texts: [
                "制作過程の動画をYouTubeに上げました。よかったらチャンネル登録と高評価をお願いします！",
                "簡単に流れを説明すると",
                "サイズを確認して",
                "利用する部分だけTシャツを切っていきます",
                "タッカーで端を止めていきます",
                "余った生地をカットして",
                "角もタッカーで止めていきます",
                "水テープを貼れば",
                "完成です！",
            ]),
        Section(
            title: "まとめ",
            texts: [
                "首元がヨレただけで見た目が気に入っているTシャツを有効活用する方法としてこういったパネルにしてしまうのはいい方法だなと思いました。タッカーの芯と水テープがまだまだあるのでパネルさえ買ってしまえば色々できるなと思うと今後も色々作りたくなってきました。",
                "この記事がTシャツなどの処分に困っている人のヒントになれば嬉しいです。",
            ]),
    ]
}
