//
//  PokemonListCell.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 01/10/2023.
//

import SnapKit
import UIKit

struct PokemonCellModel {
    let number: Int
    let name: String
    let elements: [ElementModel]
    let iconName: String

    var mainColor: UIColor? {
        elements.first?.color
    }
}

struct ElementModel {
    let color: UIColor
    let iconImageName: String
    let name: String
}

final class PokemonTableListCell: UITableViewCell {
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = FontStyle.header1.font()
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = FontStyle.title1.font()
        return label
    }()

    private let elementView: ElementView = {
        let view = ElementView()
        return view
    }()

    private let elementsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        return stackView
    }()

    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        return stackView
    }()

    private let textInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 6
        return stackView
    }()

    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        let heartImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        button.setImage(heartImage, for: .normal)
        button.tintColor = .red
        button.addTarget(PokemonTableListCell.self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()

    private let iconBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()

    private let pokemonIconView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = UIImage(systemName: "shoeprints.fill")
        return iconView
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
}

// MARK: - Public methods

extension PokemonTableListCell {
    func configure(with model: PokemonCellModel?) {
        numberLabel.text = "№" + (model?.number.description ?? "")
        nameLabel.text = model?.name

        elementsStackView.arrangedSubviews.forEach {
            elementsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        model?.elements.forEach { model in
            let elementView = ElementView()
            elementView.configure(with: model)
            elementsStackView.addArrangeSubviews(elementView)
            elementView.snp.makeConstraints { make in
                make.height.equalToSuperview()
            }
        }
        contentView.backgroundColor = model?.mainColor?.withAlphaComponent(0.1)
        iconBackground.backgroundColor = model?.mainColor
    }

    @objc func buttonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()

        if sender.isSelected {
            sender.backgroundColor = .red
            sender.tintColor = .white
        } else {
            sender.backgroundColor = .clear
            sender.tintColor = nil
        }
    }
}

private extension PokemonTableListCell {
    func setupUI() {
        selectionStyle = .none
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true

        labelsStackView.addArrangeSubviews(numberLabel, nameLabel)
        textInfoStackView.addArrangeSubviews(labelsStackView, elementsStackView)
        iconBackground.addSubviews(pokemonIconView, favoriteButton)

        contentView.addSubviews(
            textInfoStackView,
            iconBackground
        )

        textInfoStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.left.equalToSuperview().offset(16)
        }

        elementsStackView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(26)
        }

        iconBackground.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2.6)
            make.left.equalTo(textInfoStackView.snp.right).offset(12)
            make.top.right.bottom.equalToSuperview()
        }

        pokemonIconView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
