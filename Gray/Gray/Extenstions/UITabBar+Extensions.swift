//
//  UITabBar+Extensions.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 30/11/2022.
//

import UIKit

extension UITabBar: GrayscaleView {
    
    var canApplySubviewsGrayscale: Bool { false }
    
    func applyGrayscale(duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.tintColor = self?.tintColor?.grayScale
        })
    }
    
    func reverseGrayscale(duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            self?.tintColor = self?.originalTintColor
        })
    }
}
