//
//  UISwitch+Extensions.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 30/11/2022.
//

import UIKit

private struct AssociatedKeys {
    static var originalOnTintColor = "originalOnTintColor"
    static var originalThumbTintColor = "originalThumbTintColor"
}

extension UISwitch: GrayscaleView {
    // MARK: - Properties
    private(set) var originalOnTintColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.originalOnTintColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.originalOnTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private(set) var originalThumbTintColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.originalThumbTintColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.originalThumbTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Methods
    func applyGrayscale(duration: TimeInterval) {
        let defaultTintColor = UIColor.systemGreen
        let defaultThumbColor = UIColor.white
        
        // store original colors
        //self.originalTintColor = self.onTintColor ?? defaultTintColor
        self.originalOnTintColor = self.onTintColor ?? defaultTintColor
        self.originalThumbTintColor = self.thumbTintColor ?? defaultThumbColor
        
        // apply grayscale
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.tintColor = (self?.tintColor ?? defaultTintColor).grayScale
            self?.onTintColor = (self?.onTintColor ?? defaultTintColor).grayScale
            self?.thumbTintColor = (self?.thumbTintColor ?? defaultThumbColor).grayScale
        })
    }
    
    func reverseGrayscale(duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.tintColor = self?.originalTintColor
            self?.onTintColor = self?.originalOnTintColor
            self?.thumbTintColor = self?.originalThumbTintColor
        })
    }
}
