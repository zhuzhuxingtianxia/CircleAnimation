//
//  TestRing3.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/5.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class TestRing3: UIView {
    
    //进度
    public var progress:CGFloat = 0.0 {
        didSet{
            if progress>=100 {
                progress = 100
            }
            textLabel.text = "\(progress)"
            textLabel.sizeToFit()
            
            setNeedsDisplay()
        }
    }
    
    lazy private var textLabel:UILabel = {
        let label = UILabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.red
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel.center = CGPoint(x: frame.width/2, y: frame.height/2)
    }

    
    override func draw(_ rect: CGRect){
        
        UIColor.red.set()
        
        let localProgress = min(1.0, max(0.0,  progress/100.0))
        
        let progressAngle = localProgress * 360.0 - 90
        let center = CGPoint.init(x: rect.width/2.0, y: rect.height/2.0)
        let bezierPath = UIBezierPath.init()
        
        bezierPath.append(UIBezierPath.init(arcCenter: center, radius: rect.width/2, startAngle: radiansAngle(-90), endAngle: radiansAngle(progressAngle), clockwise: true))
        bezierPath.addArc(withCenter:center, radius: rect.width/2 - 10, startAngle: radiansAngle(progressAngle), endAngle: radiansAngle(-90), clockwise: false)
        
        bezierPath.close()
        bezierPath.fill()
        
    }
    
    private func radiansAngle(_ angle:CGFloat)->CGFloat{
        return angle / 180.0 * .pi
    }
    


}
