//
//  UIView+.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 01/10/2023.
//

import SnapKit
import UIKit

extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}

extension UIView {
    func showRotationLoader(constantY: CGFloat,
                            color: UIColor = .systemOrange,
                            needWhiteBackground: Bool = true) {
        if self.viewWithTag(Constants.ViewTag.loader) != nil { return }
        let loaderBackgroundView = UIView.init(frame: self.bounds)
        if needWhiteBackground {
            loaderBackgroundView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
        }
        loaderBackgroundView.tag = Constants.ViewTag.loader
        let loaderImageView = UIImageView(image: UIImage(named: "loader"))
        loaderImageView.contentMode = .scaleToFill
        
        if loaderImageView.layer.animation(forKey: "rotation") == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = 1
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Float(Double.pi * 2.0)
            animate.isRemovedOnCompletion = false
            loaderImageView.layer.add(animate, forKey: "rotation")
        }
        
        self.addSubview(loaderBackgroundView)
        loaderBackgroundView.addSubview(loaderImageView)
        
        loaderImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        loaderBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func hideRotationLoader() {
        guard let loaderBackgroundView = self.viewWithTag(Constants.ViewTag.loader) else { return }
        loaderBackgroundView.layer.removeAllAnimations()
        loaderBackgroundView.removeFromSuperview()
    }

    func showRootViewLoader() {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.view.showRotationLoader(constantY: 0)
        }
    }
    
    func hideRootViewLoader() {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.view.hideRotationLoader()
        }
    }
}
