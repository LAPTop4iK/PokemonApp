//
//  SeparatorView.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//

import SnapKit
import UIKit

final class SeparatorView: UIView {
    // MARK: - Initializer

    init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup View

    private func setupView() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        backgroundColor = .lightGray
    }
}
