//
// Knob.swift
// Copyright © 2016 Luis Vieira Damiani. All rights reserved.
//

import UIKit

@IBDesignable public class Knob: UIControl {
    
    let numberOfItems : CGFloat = 270
    let pi = CGFloat(M_PI)
    let radiansToDegrees = 180 / M_PI
    var label : UILabel!
    @IBInspectable public var baseColor = UIColor.magentaColor()
    @IBInspectable public var outlineColor = UIColor.darkGrayColor()
    @IBInspectable public var value : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override public func drawRect(rect: CGRect) {
        let center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        let radius = max(self.frame.width, self.frame.height)
        let arcWidth : CGFloat = radius * 0.2
        let startAngle = 0.75 * pi
        let endAngle = 0.25 * pi
        let angleDifference = 2 * pi - startAngle + endAngle
        let arcLengthPerItem = angleDifference / numberOfItems
        let mutableEndAngle = arcLengthPerItem * value + startAngle
        let path = UIBezierPath(arcCenter: center, radius: 0.5 * (radius - arcWidth), startAngle: startAngle, endAngle: mutableEndAngle, clockwise: true)
        path.lineWidth = arcWidth
        baseColor.setStroke()
        path.stroke()
        let outlinePath = UIBezierPath(arcCenter: center, radius: 0.5 * self.frame.width - 1, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        outlinePath.addArcWithCenter(center, radius: 0.5 * self.frame.width - arcWidth + 1, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        outlinePath.closePath()
        outlinePath.lineWidth = 1.5
        outlineColor.setStroke()
        outlinePath.stroke()
    }
    
    override public func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        let center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
        let angle = atan2(Double(location.y - center.y), Double(location.x - center.x)) * radiansToDegrees + 225
        let convertedAngle = CGFloat(Int(angle) % 360)
        if convertedAngle <= numberOfItems {
            self.value = convertedAngle
        }
        self.sendActionsForControlEvents(.ValueChanged)
        return true
    }

}

@IBDesignable class BorderView : UIView {
    
    @IBInspectable var baseColor = UIColor.darkGrayColor()
    @IBInspectable var border : CGFloat = 10
    
    override func drawRect(rect: CGRect) {
        let width = self.frame.width
        let height = self.frame.height
        let rect = CGRect(x: border, y: border, width: width - 2 * border, height: height - 2 * border)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: self.frame.height * 0.1)
        path.lineWidth = 3
        baseColor.setStroke()
        path.stroke()
    }
    
}