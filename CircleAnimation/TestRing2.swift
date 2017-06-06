//
//  TestRing2.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/5.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class TestRing2: UIView {
    private var fillOrStroke:Bool?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fillOrStroke = (arc4random()%2 == 1) ? true:false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //进度
    public var progress:CGFloat = 0.0 {
        didSet{
            if progress>=100 {
                progress = 100
            }
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect){
        UIColor.red.set()
        
        let localProgress = min(1.0, max(0.0,  progress/100.0))
        
        let progressAngle = localProgress * 360.0 - 90
        let center = CGPoint.init(x: rect.width/2.0, y: rect.height/2.0)
        let bezierPath = UIBezierPath.init(arcCenter: center, radius: rect.width/2, startAngle: radiansAngle(progressAngle), endAngle: radiansAngle(-90), clockwise: false)
        
        if progress < 100 {
            bezierPath.addLine(to: center)
        }
        //形成闭合
        bezierPath.close()
        if fillOrStroke! {
            //填充
            bezierPath.fill()
        }else{
            //边缘线宽
            bezierPath.lineWidth = 2.0
            //边缘线
            bezierPath.stroke()
        }
        
    }
    
    private func radiansAngle(_ angle:CGFloat)->CGFloat{
        return angle / 180.0 * .pi
    }


}
