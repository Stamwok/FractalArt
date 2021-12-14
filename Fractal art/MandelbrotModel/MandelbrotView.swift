//
//  MandelbrotView.swift
//  Fractal art
//
//  Created by  Егор Шуляк on 7.12.21.
//

import Foundation
import UIKit


class MandelbrotView: UIView {
    
    var startTime: NSDate = NSDate()
    var endTime: NSDate = NSDate()
    var complexPlane = ComplexPlane()
    var pixelValue = 1.0
    var iterationCount = 100
    var rect: CGRect = .zero
    var zoomVal: Double = 1.4
    var colorSet = [UIColor]()
    
    override func draw(_ rect: CGRect) {
        initializeColors()
        drawMandelbrotOnComplexPlane(rect: rect)
        self.rect = rect
    }
    
    func createMandelbrotRectFor(complex: Complex, zoomVal: Double) {
        self.zoomVal = zoomVal
        let zoom = Double(2.0 / Double(zoomVal))
        var topLeftPoint = complex
        var bottomRightPoint = complex
        topLeftPoint.real = topLeftPoint.real - zoom
        topLeftPoint.imagine = topLeftPoint.imagine - zoom
        bottomRightPoint.real = bottomRightPoint.real + zoom
        bottomRightPoint.imagine = bottomRightPoint.imagine + zoom
        
        //Initialize complex plane with zoom level
        self.complexPlane = ComplexPlane(topLeftPoint, bottomRightPoint)
        self.setNeedsDisplay()
    }
    
    func drawMandelbrotOnComplexPlane(rect: CGRect) {
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        for xVal in stride(from: 0, to: width, by: pixelValue) {
            for yVal in stride(from: 0, to: height, by: pixelValue) {
                let complexNum = self.convertViewCoordinatesToComplexCoordinates(x: xVal, y: yVal, rect: rect)
                let color = self.implementMandelbrotEquationOn(complexNum: complexNum)
                let path = UIBezierPath(rect: CGRect(x: xVal, y: yVal, width: pixelValue, height: pixelValue))
                color.set()
                path.fill()
            }
        }
    }
    
    func implementMandelbrotEquationOn(complexNum: Complex) -> UIColor {
        var Zn = Complex()
        let c = complexNum
        for i in 1...iterationCount {
            Zn = Zn * Zn + c
            var absoluteNumber: Double {
                let realSquare = Zn.real*Zn.real
                let imagineSquare = Zn.imagine*Zn.imagine
                let riSquare = realSquare + imagineSquare
                let modulus = sqrt(riSquare)
                return modulus
            }
            if absoluteNumber >= 2 {
                return colorSet[i]
            }
        }
        return .black
    }
    
    func convertViewCoordinatesToComplexCoordinates(x: Double, y: Double, rect: CGRect) -> Complex {
        let topLeft = complexPlane.topLeft
        let bottomRight = complexPlane.bottomRight
        
        let xPlot = x/Double(rect.size.width)
        let yPlot = y/Double(rect.size.height)
        
        let topReal = topLeft.real
        let bottomReal = xPlot * (bottomRight.real - topLeft.real)
        
        let topImagine = topLeft.imagine
        let bottomImagine = yPlot * (bottomRight.imagine - topLeft.imagine)
        
        let real = topReal + bottomReal
        let imagine = topImagine + bottomImagine
        
        return Complex(real: real, imagine: imagine)
    }
    
    func initializeColors() {
        colorSet.removeAll()
        for i in 0...iterationCount {
            var float: CGFloat {
                return CGFloat(arc4random()) / CGFloat(UInt32.max)
            }
            let r = float
            let g = float
            let b = float
            colorSet.append(UIColor.init(red: r, green: g, blue: b, alpha: 1.0))
        }
    }
    
    @IBAction func handlePanGesture (sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            var center = sender.location(in: self)
            print(center)
            zoomVal *= 2
            self.createMandelbrotRectFor(complex: self.convertViewCoordinatesToComplexCoordinates(x: center.x, y: center.y, rect: self.rect), zoomVal: zoomVal)
        }
    }
}
