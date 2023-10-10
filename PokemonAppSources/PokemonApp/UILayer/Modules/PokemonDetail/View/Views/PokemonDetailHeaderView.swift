//
//  PokemonDetailHeaderView.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 03/10/2023.
//

import SnapKit
import UIKit

final class PokemonDetailHeaderView: UIView {
    private var delegate: ImageDownloaderDelegate?

    private let circleView = ResizableCircleView()

    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = FontStyle.title1.font()
        return label
    }()

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = FontStyle.header1.font()
        return label
    }()

    private let elementsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        return stackView
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = FontStyle.description.font()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    let descriptionContainer = UIView()

    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        return stackView
    }()

    private lazy var stackLeft: UIStackView = {
        let stackLeft = UIStackView()
        stackLeft.axis = .vertical
        stackLeft.distribution = .fill
        stackLeft.alignment = .fill
        return stackLeft
    }()

    private lazy var stackRight: UIStackView = {
        let stackRight = UIStackView()
        stackRight.axis = .vertical
        stackRight.distribution = .fill
        stackRight.alignment = .fill
        return stackRight
    }()

    private lazy var outerStack: UIStackView = {
        let outerStack = UIStackView()
        outerStack.axis = .horizontal
        outerStack.distribution = .fillEqually
        outerStack.spacing = 20
        outerStack.alignment = .top
        return outerStack
    }()

    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 20
        return stackView
    }()

    let separatorView = SeparatorView()

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureWith(model: DetailPokemonInfo, delegate: ImageDownloaderDelegate) {
        self.delegate = delegate

        circleView.setBaseColor(model.mainColor)

        if let image = UIImage(systemName: "flame") {
            let newImageSize = CGSize(width: image.size.width * 10, height: image.size.height * 10)
            pokemonImageView.snp.updateConstraints { make in
                make.height.equalTo(newImageSize.height)
                make.width.equalTo(newImageSize.width)
            }
        }

        nameLabel.text = model.name.capitalized
        numberLabel.text = "№\(model.id)"
        descriptionLabel.text = model.flavorText
        var models = [ShortInfoCardModel]()
        models.append(.init(name: "Weight", value: model.weight.description, image: ""))
        models.append(.init(name: "Height", value: model.height.description, image: ""))

        for model in models {
            let view = ShortInfoCardView()
            view.configureFrom(model: model)
            if stackLeft.arrangedSubviews.count >= stackRight.arrangedSubviews.count {
                stackRight.addArrangedSubview(view)
            } else {
                stackLeft.addArrangedSubview(view)
            }
            outerStack.layoutIfNeeded()
        }

        model.types.forEach { type in
            let elementView = ElementView()
            elementView.configure(with: type)
            elementsStackView.addArrangeSubviews(elementView)
            elementView.snp.makeConstraints { make in
                make.height.equalToSuperview()
            }
        }

        if let url = URL(string: model.imageUrl ?? "") {
            delegate.setImageForImageView(pokemonImageView, imageURL: url)
        }
    }

    func handleScrollWith(range: ClosedRange<CGFloat>?) {
        circleView.heightRange = range
    }
}

private extension PokemonDetailHeaderView {
    func setupViews() {
        outerStack.addArrangeSubviews(stackLeft, stackRight)
        addSubviews(circleView, containerStackView)
        labelsStackView.addArrangeSubviews(nameLabel, numberLabel)
        descriptionContainer.addSubview(descriptionLabel)
        containerStackView.addArrangeSubviews(
            pokemonImageView,
            labelsStackView,
            elementsStackView,
            descriptionContainer,
            separatorView,
            outerStack
        )
        containerStackView.setCustomSpacing(35, after: pokemonImageView)
    }

    func setupConstraints() {
        circleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.height.equalTo(500)
            make.centerX.equalToSuperview()
        }

        elementsStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(36)
        }

        labelsStackView.snp.makeConstraints { make in
            make.height.equalTo(75)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }

        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }

        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(-250)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        outerStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
        }
    }
}
