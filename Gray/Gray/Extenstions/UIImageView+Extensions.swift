//
//  UIImageView+Extensions.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 30/11/2022.
//

import UIKit
import simd

// TODO: - prevent grayscaling many times by storing original image, and boolean to know if it is already grayscaled
extension UIImageView: GrayscaleView {
    func applyGrayscale(duration: TimeInterval) {
        self.convertImageToGrayscale()
        //self.convertImageToGrayscaleAnimated(duration: duration)
    }
    
    func reverseGrayscale(duration: TimeInterval) {
        
    }
    
    private func convertImageToGrayscale() {
        guard let image = self.image else { return }
        
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIPhotoEffectNoir") {
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            if let output = filter.outputImage {
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    let grayscaleImage = UIImage(cgImage: cgImage)
                    self.image = grayscaleImage
                }
            }
        }
    }
    
    private func convertImageToGrayscaleAnimated(duration: TimeInterval) {
        // animated grayscale
        //        sourceCIImage = CIImage(image: UIImage(named: "image")!)
        //        finalCIImage = CIImage(image: getImageFiltered()!)
        //
        //        beginTransition()
    }
    
}

// apply animated filter

fileprivate class ImageGrayScaleAnimator {
    var time: TimeInterval!
    var dt: Double!
    var displayLink: CADisplayLink!
    
    var sourceCIImage: CIImage!
    var finalCIImage: CIImage!
    
    var imageView: UIImageView!
    
    func getImageFiltered() -> UIImage? {
        // TODO: - get image from imageview
        guard let image = UIImage(named: "image") else { return nil }
        
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIPhotoEffectNoir") {
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            if let output = filter.outputImage {
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    let grayscaleImage = UIImage(cgImage: cgImage)
                    return grayscaleImage
                }
            }
        }
        
        return nil
    }
    
    func dissolveFilter(_ inputImage: CIImage,
                        to targetImage: CIImage,
                        time: TimeInterval) -> CIImage? {
        
        let inputTime = simd_smoothstep(0, 1, time)
        
        guard let filter = CIFilter(name:"CIDissolveTransition",
                                    parameters:
                                        [
                                            kCIInputImageKey: inputImage,
                                            kCIInputTargetImageKey: targetImage,
                                            kCIInputTimeKey: inputTime
                                        ]) else {
            return nil
        }
        
        return filter.outputImage
    }
    
    func pixelateFilter(_ inputImage: CIImage, time: TimeInterval) -> CIImage? {
        
        let inputScale = simd_smoothstep(1, 0, abs(time))
        
        guard let filter = CIFilter(name:"CIPixellate",
                                    parameters:
                                        [
                                            kCIInputImageKey: inputImage,
                                            kCIInputScaleKey: inputScale
                                        ]) else {
            return nil
        }
        
        return filter.outputImage
    }
    
    func beginTransition() {
        
        time = 0
        dt = 0.005
        
        displayLink = CADisplayLink(target: self,
                                    selector: #selector(stepTime))
        displayLink.add(to: RunLoop.current,
                        forMode: RunLoop.Mode.default)
    }
    
    let ciContext = CIContext(options: nil)
    
    @objc func stepTime() {
        
        time += dt
        
        // End transition after 1 second
        if time > 1 {
            displayLink.remove(from:RunLoop.main, forMode:RunLoop.Mode.default)
        } else {
            guard let dissolvedCIImage = dissolveFilter(sourceCIImage,
                                                        to:finalCIImage,
                                                        time:time) else {
                return
            }
            guard let pixelatedCIImage = pixelateFilter(dissolvedCIImage,
                                                        time:time) else {
                return
            }
            // imageView and ciContext are properties of the class.
            showCIImage(pixelatedCIImage, in: imageView, context: ciContext)
        }
    }
    
    func showCIImage(_ ciImage: CIImage, in imageView: UIImageView, context: CIContext) {
        
        guard let cgImage = context.createCGImage(ciImage,
                                                  from: ciImage.extent) else {
            return
        }
        let uiImage = UIImage(cgImage:cgImage)
        
        imageView.image = uiImage
    }
}
