//
//  ComplexNumbers.swift
//  Fractal art
//
//  Created by  Егор Шуляк on 7.12.21.
//

import Foundation

struct Complex: Equatable {
    var real: Double
    var imagine: Double
    init() {
        self.init(real: 0, imagine: 0)
    }
    
    init(real: Double, imagine: Double) {
        self.real = real
        self.imagine = imagine
    }
    
    static func ==(lhs: Complex, rhs: Complex) -> Bool {
        return lhs.real == rhs.real && lhs.imagine == rhs.imagine
    }

    static func +(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real + rhs.real, imagine: lhs.imagine + rhs.imagine)
    }

    static func *(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real * rhs.real - lhs.imagine * rhs.imagine, imagine: lhs.real * rhs.imagine + rhs.real * lhs.imagine)
    }
}
