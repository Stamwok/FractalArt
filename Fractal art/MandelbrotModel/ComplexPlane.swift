//
//  ComplexPlane.swift
//  Fractal art
//
//  Created by  Егор Шуляк on 7.12.21.
//

import Foundation

class ComplexPlane{
    static func == (lhs: ComplexPlane, rhs: ComplexPlane) -> Bool {
        return true
    }
    
    var topLeft = Complex()
    var topRight = Complex()
    var bottomLeft = Complex()
    var bottomRight = Complex()
    
//    override init() {
//        super.init()
//    }
    init () {
        
    }
    
    init (_ c1: Complex, _ c2: Complex) {
        let tl_real = min(c1.real, c2.real)
        let tl_imagine = max(c1.imagine, c2.imagine)
        let br_real = max(c1.real, c2.real)
        let br_imagine = min(c1.imagine, c2.imagine)
        topLeft = Complex(real: tl_real, imagine: tl_imagine)
        topRight = Complex(real: br_real, imagine: tl_imagine)
        bottomLeft = Complex(real: tl_real, imagine: br_imagine)
        bottomRight = Complex(real: br_real, imagine: br_imagine)
    }
    
    
}
