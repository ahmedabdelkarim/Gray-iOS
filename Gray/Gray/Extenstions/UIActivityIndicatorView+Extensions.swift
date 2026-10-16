//
//  UIActivityIndicatorView+Extensions.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 01/12/2022.
//

import UIKit

extension UIActivityIndicatorView: GrayscaleView {
    
    func applyGrayscale(duration: TimeInterval) {
        UIView.transition(with: self, duration: duration, options: [.transitionCrossDissolve, .allowUserInteraction], animations: { [weak self] in
            if let imageView = self?.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                imageView.applyGrayscale(duration: duration)
            }
        })
    }
    
    func reverseGrayscale(duration: TimeInterval) {
        
    }
}
