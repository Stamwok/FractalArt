//
//  ViewController.swift
//  Fractal art
//
//  Created by  Егор Шуляк on 7.12.21.
//

import UIKit

class ViewController: UIViewController {
    
//    var center = CGPoint
//    var zoomVal: Double = 1.4
    
    @IBOutlet var mandelbrotView: MandelbrotView!
    @IBOutlet var count: UILabel!
    @IBAction func reset(_ sender:UIButton) {
        mandelbrotView.createMandelbrotRectFor(complex: Complex(), zoomVal: 1.4)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mandelbrotView.createMandelbrotRectFor(complex: Complex(), zoomVal: 1.4)
    }
    
        
}

