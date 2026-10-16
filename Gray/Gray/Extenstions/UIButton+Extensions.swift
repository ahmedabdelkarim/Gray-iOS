//
//  UIButton+Extensions.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 02/12/2022.
//

import UIKit

private struct AssociatedKeys {
    static var originalTitleColor = "originalTitleColor"
}

extension UIButton: GrayscaleView {
    // MARK: - Properties
    private(set) var originalTitleColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.originalTitleColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.originalTitleColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Methods
    func applyGrayscale(duration: TimeInterval) {
        // store original colors
        //self.originalBackgroundColor = self.backgroundColor
        self.originalTitleColor = self.titleColor(for: .normal)

        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.backgroundColor = self?.backgroundColor?.grayScale
            self?.setTitleColor(self?.originalTitleColor?.grayScale, for: .normal)
        })
    }
    
    func reverseGrayscale(duration: TimeInterval) {
        super.reverseUIViewGrayscale(duration: duration)
        
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.backgroundColor = self?.originalBackgroundColor
            self?.setTitleColor(self?.originalTitleColor, for: .normal)
        })
    }
}
