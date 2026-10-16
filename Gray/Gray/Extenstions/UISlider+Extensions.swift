//
//  UISlider+Extensions.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 30/11/2022.
//

import UIKit

private struct AssociatedKeys {
    static var originalThumbTintColor = "originalThumbTintColor"
}

extension UISlider: GrayscaleView {
    // MARK: - Properties
    private(set) var originalThumbTintColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.originalThumbTintColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.originalThumbTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var canApplySubviewsGrayscale: Bool { false }
    
    // MARK: - Methods
    
    func applyGrayscale(duration: TimeInterval) {
        let defaultThumbColor = UIColor.white
        
        // store original colors
        self.originalTintColor = self.tintColor
        self.originalThumbTintColor = self.thumbTintColor ?? defaultThumbColor
        
        // apply grayscale
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.tintColor = self?.tintColor?.grayScale
            self?.thumbTintColor = (self?.thumbTintColor ?? defaultThumbColor).grayScale
        })
    }
    
    func reverseGrayscale(duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.tintColor = self?.originalTintColor
            self?.thumbTintColor = self?.originalThumbTintColor
        })
    }
}
