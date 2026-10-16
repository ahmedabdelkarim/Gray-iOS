//
//  UIProgressView+Extensions.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 30/11/2022.
//

import UIKit

extension UIProgressView: GrayscaleView {
    
    var canApplySubviewsGrayscale: Bool { false }
    
    func applyGrayscale(duration: TimeInterval) {
        // store original colors
        self.originalTintColor = self.tintColor
        
        // apply grayscale
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.tintColor = self?.tintColor?.grayScale
        })
    }
    
    func reverseGrayscale(duration: TimeInterval) {
        super.reverseUIViewGrayscale(duration: duration)
        
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.tintColor = self?.originalTintColor
        })
    }
}
