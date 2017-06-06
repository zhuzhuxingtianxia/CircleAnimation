//
//  TestRing1.swift
//  CircleAnimation
//
//  Created by Jion on 2017/5/31.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class TestRing1: UIView {

    //进度
    public var progress:CGFloat = 0.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect){
        UIColor.red.set()
        //let context = UIGraphicsGetCurrentContext()
        //context?.saveGState()
        let localProgress = min(1.0, max(0.0,  progress/100.0))
        
        let progressAngle = localProgress * 360.0 - 90
        let center = CGPoint.init(x: rect.width/2.0, y: rect.height/2.0)
         let bezierPath = UIBezierPath.init(arcCenter: center, radius: rect.width/2, startAngle: radiansAngle(progressAngle), endAngle: radiansAngle(-90), clockwise: false)
        bezierPath.fill()
       
    }
    
    private func radiansAngle(_ angle:CGFloat)->CGFloat{
        return angle / 180.0 * .pi
    }

}
