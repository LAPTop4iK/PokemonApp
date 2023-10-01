//
//  SearchView.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 01/10/2023.
//

import SnapKit
import UIKit

class SearchView: UIView {
    var output: SearchViewOutput?

    private let searchNotActiveView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()

    private let searchNotActiveRightImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "search_black"))
//        imageView.tintColor = ColorStyle.darkGrayText.color()
        imageView.isUserInteractionEnabled = false
        return imageView
    }()

    private let searchNotActiveLabel: UILabel = {
        let label = UILabel()
        label.text = "Искать поставщика услуг"
//        label.textColor = UIColor(.grayTitle)
//        label.font = FontStyle.header2.font()
        return label
    }()

    private let searchIsActiveView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()

    private let searchIsActiveRightImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.tintColor = ColorStyle.darkGrayText.color()
        imageView.isUserInteractionEnabled = false
        return imageView
    }()

    private let searchIsActiveTextField: UITextField = {
        let textField = UITextField()
//        textField.font = FontStyle.header2.font()
//        textField.textColor = ColorStyle.darkGrayText.color()
        textField.backgroundColor = .clear
        textField.borderStyle = .none
//        textField.tintColor = ColorStyle.darkGrayText.color()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        return textField
    }()

    // Метод инициализации
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    init(presenter: SearchViewOutput?, delegate: UITextFieldDelegate) {
        super.init(frame: .zero)

        output = presenter
        searchIsActiveTextField.delegate = delegate
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(searchNotActiveView)
        searchNotActiveView.addSubview(searchNotActiveRightImageView)
        searchNotActiveView.addSubview(searchNotActiveLabel)

        addSubview(searchIsActiveView)
        searchIsActiveView.addSubview(searchIsActiveRightImageView)
        searchIsActiveView.addSubview(searchIsActiveTextField)

        setupConstraints()

        let gr1 = UITapGestureRecognizer(target: self, action: #selector(notActiveViewTapped(_:)))
        searchNotActiveView.addGestureRecognizer(gr1)

        let gr2 = UITapGestureRecognizer(target: self, action: #selector(activeViewTapped(_:)))
        searchIsActiveView.addGestureRecognizer(gr2)
    }

    private func setupConstraints() {
//        searchNotActiveView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        searchNotActiveRightImageView.snp.makeConstraints { make in
//            // Добавьте нужные констрейнты
//        }
//
//        searchNotActiveLabel.snp.makeConstraints { make in
//            // Добавьте нужные констрейнты
//        }
//
//        searchIsActiveView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        searchIsActiveRightImageView.snp.makeConstraints { make in
//            // Добавьте нужные констрейнты
//        }
//
//        searchIsActiveTextField.snp.makeConstraints { make in
//            // Добавьте нужные констрейнты
//        }
    }

    @objc func notActiveViewTapped(_: UITapGestureRecognizer) {
        bringSubviewToFront(searchIsActiveView)
        searchIsActiveTextField.becomeFirstResponder()
        output?.didSetActive()
    }

    @objc func activeViewTapped(_: UITapGestureRecognizer) {
        bringSubviewToFront(searchNotActiveView)
        searchIsActiveTextField.resignFirstResponder()
        output?.didSetNotActive()
    }
}

extension SearchView: SearchViewInput {
    func clearSearch() {
        searchIsActiveTextField.text = ""
    }

    func disableSearch() {
        bringSubviewToFront(searchNotActiveView)
        searchIsActiveTextField.resignFirstResponder()
    }

    func setPlaceholder(_ text: String) {
        searchNotActiveLabel.text = text
    }
}
