//
//  ElementView.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 01/10/2023.
//

import SnapKit
import UIKit

class ElementView: UIView {
    private let circularView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontStyle.text1.font()
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        circularView.circle()
        roundView(frame.height / 2)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: ElementModel) {
        backgroundColor = model.color
        iconImageView.image = UIImage(systemName: model.iconImageName) ??
            UIImage(named: model.iconImageName)
        nameLabel.text = model.name
        nameLabel.textColor = model.color.isDark ? .white : .black
    }
}

private extension ElementView {
    func setupViews() {
        layer.masksToBounds = true
        addSubview(circularView)
        circularView.addSubview(iconImageView)
        addSubview(nameLabel)
    }

    func setupConstraints() {
        circularView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(22)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.9)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(circularView.snp.trailing).inset(6)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
