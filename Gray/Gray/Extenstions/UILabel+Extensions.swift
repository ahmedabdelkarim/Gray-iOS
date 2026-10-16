//
//  UILabel+Extensions.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 30/11/2022.
//

import UIKit

private struct AssociatedKeys {
    static var originalTextColor = "originalTextColor"
}

extension UILabel: GrayscaleView {
    // MARK: - Properties
    private(set) var originalTextColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.originalTextColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.originalTextColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Methods
    func applyGrayscale(duration: TimeInterval) {
        // store original colors
        self.originalTextColor = self.textColor
        
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.textColor = self?.textColor?.grayScale
        })
    }
    
    func reverseGrayscale(duration: TimeInterval) {
        super.reverseUIViewGrayscale(duration: duration)
        
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.textColor = self?.originalTextColor
        })
    }
}
