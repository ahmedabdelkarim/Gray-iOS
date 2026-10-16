//
//  UIView+Extensions.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 30/11/2022.
//

import UIKit

// TODO: - apply effect using percentage (0 is no effect, 1 is 100% gray scaled)

private struct AssociatedKeys {
    static var originalBackgroundColor = "originalBackgroundColor"
    static var originalTintColor = "originalTintColor"
}

extension UIView {
    // MARK: - Properties
    var originalBackgroundColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.originalBackgroundColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.originalBackgroundColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var originalTintColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.originalTintColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.originalTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Methods
    func applyGrayscale(recursive: Bool = false, applyToImages: Bool = true, duration: TimeInterval = 3) {
        // prevent applying effect on images if required
        if applyToImages == false && self is UIImageView {
            return
        }
        
        // store original colors
        self.originalBackgroundColor = self.backgroundColor
        self.originalTintColor = self.tintColor
        
        // apply grayscale
        if let grayScaleView = self as? GrayscaleView {
            grayScaleView.applyGrayscale(duration: duration)
            
            // prevent changing colors of subviews if it will handle internally
            if grayScaleView.canApplySubviewsGrayscale == false {
                return
            }
        }
        else {
            
            
            self.applyUIViewGrayscale(applyToTint: false, duration: duration)
        }
        
        // don't apply on subviews if recursive is false
        if recursive == false {
            return
        }
        
        for subView in self.subviews {
            subView.applyGrayscale(recursive: recursive, applyToImages: applyToImages, duration: duration)
        }
    }
    
    private func applyUIViewGrayscale(applyToTint: Bool, duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.backgroundColor = self?.backgroundColor?.grayScale
            if applyToTint {
                self?.tintColor = self?.tintColor?.grayScale
            }
        })
    }
    
    func reverseGrayscale(recursive: Bool = false, duration: TimeInterval = 3) {
        // reverse grayscale
        //self.reverseUIViewGrayscale(duration: duration)
        
        if let grayScaleView = self as? GrayscaleView {
            grayScaleView.reverseGrayscale(duration: duration)
            
            // prevent changing colors of subviews if it will handle internally
            if grayScaleView.canApplySubviewsGrayscale == false {
                return
            }
        }
//        else {
//            self.reverseUIViewGrayscale(duration: duration)
//        }
        
        // don't apply on subviews if recursive is false
        if recursive == false {
            return
        }
        
        for subView in self.subviews {
            subView.reverseGrayscale(recursive: recursive, duration: duration)
        }
    }
    
    func reverseUIViewGrayscale(duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.backgroundColor = self?.originalBackgroundColor
            //self?.tintColor = self?.originalTintColor
        })
    }
}
