//
//  UIColor+Extensions.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 30/11/2022.
//

import UIKit

extension UIColor {
    var grayScale: UIColor? {
        var white: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard self.getWhite(&white, alpha: &alpha) else {
            return nil
        }
        
        return UIColor(white: white, alpha: alpha)
    }
}
