//
//  TestRing7.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/6.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class TestRing7: UIView {

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
        
        let context = UIGraphicsGetCurrentContext()!
        
        let localProgress = min(1.0, max(0.0,  progress/100.0))
        
        let progressAngle = localProgress * 360.0 - 90
        let center = CGPoint.init(x: rect.width/2.0, y: rect.height/2.0)
        let bezierPath = UIBezierPath.init()
        
        bezierPath.append(UIBezierPath.init(arcCenter: center, radius: rect.width/2, startAngle: radiansAngle(-90), endAngle: radiansAngle(progressAngle), clockwise: true))
        bezierPath.addArc(withCenter:center, radius: rect.width/2 - 10, startAngle: radiansAngle(progressAngle), endAngle: radiansAngle(-90), clockwise: false)
        
        //用于裁剪多余部分（例如修剪成圆形）
        bezierPath.addClip()
        
        //创建颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //设置过渡色颜色数组
        let backgroundColors1 = [UIColor.yellow.cgColor,UIColor.orange.cgColor];
        //设置渐变区域(必须是单调递增的)
        let backgroudColorLocations1:[CGFloat] = [0.2 ,0.9]
        //设置颜色过滤器
        let backgroundGradient1 = CGGradient.init(colorsSpace: colorSpace, colors: backgroundColors1 as CFArray, locations: backgroudColorLocations1)
        
        //start、end梯度变化的起,始点
        context.drawLinearGradient(backgroundGradient1!, start: CGPoint.init(x: rect.width/2, y: 0), end: CGPoint.init(x: rect.width, y: rect.height*3/4), options: CGGradientDrawingOptions(rawValue: 0))
        //渐变2
        let backgroundColors2 = [UIColor.orange.cgColor,UIColor.green.cgColor]
        
        let backgroudColorLocations2:[CGFloat] = [0.2 ,0.8]
        
        let backgroundGradient2 = CGGradient.init(colorsSpace: colorSpace, colors: backgroundColors2 as CFArray, locations: backgroudColorLocations2)
        
        context.drawLinearGradient(backgroundGradient2!, start: CGPoint.init(x: 0, y: 0), end: CGPoint.init(x: rect.width/2, y: 0), options: CGGradientDrawingOptions(rawValue: 0))
        
        //渐变3
        let backgroundColors3 = [UIColor.orange.cgColor]
        
        let backgroudColorLocations3:[CGFloat] = [1.0]
        
        let backgroundGradient3 = CGGradient.init(colorsSpace: colorSpace, colors: backgroundColors3 as CFArray, locations: backgroudColorLocations3)
        
        context.drawLinearGradient(backgroundGradient3!, start: CGPoint.init(x: 0, y: rect.height*3/4), end: CGPoint.init(x: 0, y: rect.height), options: CGGradientDrawingOptions(rawValue: 0))
        
    }

    private func radiansAngle(_ angle:CGFloat)->CGFloat{
        return angle / 180.0 * .pi
    }
    

}
