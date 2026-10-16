//
//  GrayscaleView.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 30/11/2022.
//

import Foundation
import UIKit

protocol GrayscaleView {
    // MARK: - Properties
    var canApplySubviewsGrayscale: Bool { get }
    
    // MARK: - Methods
    func applyGrayscale(duration: TimeInterval)
    func reverseGrayscale(duration: TimeInterval)
}

extension GrayscaleView {
    var canApplySubviewsGrayscale: Bool { true }
}
