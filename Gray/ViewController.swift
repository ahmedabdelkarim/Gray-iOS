//
//  ViewController.swift
//  Gray
//
//  Created by Ahmed Abdelkarim on 24/11/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func grayButton(_ sender: Any) {
        view.applyGrayscale(recursive: true, applyToImages: false, duration: 2)
    }
    
    @IBAction func reverse(_ sender: Any) {
        view.reverseGrayscale(recursive: true, duration: 2)
    }
}
