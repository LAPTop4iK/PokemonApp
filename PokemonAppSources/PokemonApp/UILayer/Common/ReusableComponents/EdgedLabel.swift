//
//  EdgedLabel.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//

import UIKit

class EdgedLabel: UILabel {

    let insets: UIEdgeInsets
    let cornerRadius: CGFloat

    init(
        font: UIFont,
        textAlignment: NSTextAlignment = .left,
        insets: UIEdgeInsets = .zero,
        textColor: UIColor? = .label,
        backgroundColor: UIColor? = .clear,
        borderColor: CGColor? = nil,
        borderWidth: CGFloat? = nil,
        numberOfLines: Int = 0,
        cornerRadius: CGFloat = 0
    ) {
        self.insets = insets
        self.cornerRadius = cornerRadius

        super.init(frame: .zero)
        self.font = font
        self.textAlignment = textAlignment
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        self.layer.cornerRadius = cornerRadius
        
        if let borderColor, let borderWidth {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor
        }

        clipsToBounds = cornerRadius > 0
        adjustsFontForContentSizeCategory = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += insets.top + insets.bottom
        contentSize.width += insets.left + insets.right
        return contentSize
    }
    
    func addLineOfText(_ text: String) {
        self.text = (self.text ?? "") + "\n\(text)"
    }
}

