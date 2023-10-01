//
//  UIView+Blur.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//

import UIKit

enum BlurStile {
    case dark
    case light
}

enum BlurPosition {
    case background
    case foreground
}

extension UIView {
    @discardableResult
    private func setBlurBackground(style: UIBlurEffect.Style) -> UIView {
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurEffectView.alpha = 1
        blurEffectView.frame = self.frame
        self.insertSubview(blurEffectView, at: 0)
        return blurEffectView
    }
    
    @discardableResult
    func setBlurBackground(stile: BlurStile) -> UIView {
        var result: UIView
        switch  stile {
        case .dark: result = setBlurBackground(style: .dark )
        case .light: result = setBlurBackground(style: .light )
        }
        return result
    }
    
    func addBlurEffect(to position: BlurPosition, style: UIBlurEffect.Style) {
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurEffectView.alpha = 0.9
        blurEffectView.frame = self.frame
        
        switch position {
        case .background:
            insertSubview(blurEffectView, at: 0)
        case .foreground:
            addSubview(blurEffectView)
        }
        
    }
    
    func removeBlurEffect() {
        let blurredViews = self.subviews.filter { $0 is UIVisualEffectView }
        blurredViews.forEach { blurredView in
            blurredView.removeFromSuperview()
        }
    }
}
