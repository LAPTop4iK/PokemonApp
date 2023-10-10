//
//  ResizableCircleView.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 03/10/2023.
//

import UIKit

class ResizableCircleView: UIView {
    // MARK: - Properties

    var sizeRatio: CGFloat = 6
    var shapeRatio: CGFloat = 4

    var heightRange: ClosedRange<CGFloat>? {
        didSet {
            setNeedsDisplay()
        }
    }

    var baseColor: UIColor = .systemYellow {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: - Functions

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.mask?.frame = bounds

        if let _ = heightRange {
            setNeedsDisplay()
        }
    }

    override func draw(_: CGRect) {
        let path = clipingPath()
        (layer.mask as? CAShapeLayer)?.path = path

        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.addPath(path)
        context.clip()

        // Render gradient
        let lighterColor = baseColor.lighter(by: 20) ?? baseColor
        let colors: [CGColor] = [baseColor.cgColor, lighterColor.cgColor]
        let locations: [CGFloat] = [0, 1]

        if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: locations) {
            context.drawLinearGradient(gradient, start: bounds.origin, end: CGPoint(x: bounds.maxX, y: bounds.maxY), options: [])
        }
    }

    func setBaseColor(_ color: UIColor?) {
        guard let color else { return }

        baseColor = color
    }
}

// MARK: - Private

private extension ResizableCircleView {
    func setup() {
        layer.mask = CAShapeLayer()
        setNeedsDisplay()
    }

    func clipingPath() -> CGPath {
        let shapeRatio = getShapeRatio()
        let horizontal = bounds.width * (1 - sizeRatio) / 2
        let vertical = bounds.height - bounds.width * (sizeRatio * shapeRatio)
        let frame = bounds.inset(by: UIEdgeInsets(top: vertical, left: horizontal, bottom: 0, right: horizontal))

        let path = CGMutablePath()
        path.addEllipse(in: frame)

        if let range = heightRange {
            let box = CGRect(x: 0, y: 0, width: bounds.width, height: max(range.lowerBound, frame.midY))
            path.addRect(box)
        }

        return path
    }

    func getShapeRatio() -> CGFloat {
        guard let range = heightRange else { return shapeRatio }

        let coef = (bounds.height - range.lowerBound) / (range.upperBound - range.lowerBound)
        return max(CGFloat.leastNonzeroMagnitude, min(coef, 1.75)) * shapeRatio
    }
}
