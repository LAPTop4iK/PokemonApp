//
//  ShortInfoCardView.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//

import UIKit

class ShortInfoCardView: UIView {
    private let infoLabel = EdgedLabel(
        font: UIFont.systemFont(ofSize: 18),
        insets: UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20),
        borderColor: UIColor.secondaryLabel.cgColor,
        borderWidth: 1,
        numberOfLines: 1,
        cornerRadius: 15
    )

    private let infoTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = .systemGray2
        return imageView
    }()

    private let infoTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.textAlignment = .left
        return label
    }()

    private let infoLabelContainer = UIView()

    private lazy var infoTypeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangeSubviews(infoTypeImageView, infoTypeLabel)
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 6
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureFrom(model: ShortInfoCardModel) {
        infoLabel.text = model.value
        infoTypeLabel.text = model.name
        infoTypeImageView.image = UIImage(systemName: "flame")
    }
}

private extension ShortInfoCardView {
    func setupViews() {
        infoLabelContainer.addSubview(infoLabel)
        addSubviews(infoTypeStackView, infoLabelContainer)
    }

    func setupConstraints() {
        infoTypeStackView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }

        infoLabelContainer.snp.makeConstraints { make in
            make.top.equalTo(infoTypeStackView.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        infoLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        infoTypeImageView.snp.makeConstraints { make in
            make.height.width.equalTo(13)
        }
    }
}
