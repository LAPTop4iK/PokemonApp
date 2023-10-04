//
//  PokemonDetailHeaderView.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 03/10/2023.
//

import UIKit
import SnapKit

final class PokemonDetailHeaderView: UIView {
    private let circleView = ResizableCircleView()
    
    private lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = FontStyle.text1.font()
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
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = FontStyle.header1.font()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionContainer = UIView()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var stackLeft: UIStackView = {
        let stackLeft = UIStackView()
        stackLeft.axis = .vertical
        stackLeft.distribution = .fillProportionally
        stackLeft.alignment = .top
        return stackLeft
    }()

    private lazy var stackRight: UIStackView = {
        let stackRight = UIStackView()
        stackRight.axis = .vertical
        stackRight.distribution = .fillProportionally
        stackRight.alignment = .top
        return stackRight
    }()

    private lazy var outerStack: UIStackView = {
        let outerStack = UIStackView()
        outerStack.axis = .horizontal
        outerStack.distribution = .fillEqually
        outerStack.alignment = .top
        return outerStack
    }()
    
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 30
        return stackView
    }()
    
    let separatorView = SeparatorView()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(model: PokemonDetailModel) {
        if let image = UIImage(systemName: "flame") {
                pokemonImageView.image = image
                let newImageSize = CGSize(width: image.size.width * 3, height: image.size.height * 3)
                pokemonImageView.snp.updateConstraints { make in
                    make.height.equalTo(newImageSize.height)
                    make.width.equalTo(newImageSize.width)
                }
            }
        
        nameLabel.text = model.name
        numberLabel.text = "№+\(model.id)"
        descriptionLabel.text = "Очень длинный текст, который занимает несколько строк и должен быть полностью видимым в UIStackView, чтобы пользователь мог прочитать всю информацию."
        
                let model = ShortInfoCardModel(name: "test", value: "11.2123123123", image: "")
                
                for _ in 0...12 {
                    let view = ShortInfoCardView()
                    view.configureFrom(model: model)
                    if stackLeft.arrangedSubviews.count >= stackRight.arrangedSubviews.count {
                        stackRight.addArrangedSubview(view)
                    } else {
                        stackLeft.addArrangedSubview(view)

                    }
                    outerStack.layoutIfNeeded()
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
