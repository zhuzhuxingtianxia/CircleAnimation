//
//  TestRing9.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/6.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class TestRing9: UIView {

    //采用Layer
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
    
    public var lineW:CGFloat = 0.0 {
        didSet{
            
            let gradientLayer1 = CAGradientLayer.init()
            
            gradientLayer1.frame = CGRect(x: frame.width/2.0 - lineW/2, y: 0, width: frame.width/2.0+lineW/2, height: frame.height/2.0)
            gradientLayer1.colors = [UIColor.red.cgColor,UIColor.orange.cgColor]
            gradientLayer1.locations = [0.3,0.8]
            gradientLayer1.startPoint = CGPoint(x: 0.2, y: 0)
            gradientLayer1.endPoint = CGPoint(x: 0.8, y: 1)
            glayer.addSublayer(gradientLayer1)
            
            let gradientLayer2 = CAGradientLayer.init()
            gradientLayer2.frame = CGRect(x: frame.width/2.0, y: frame.height/2.0, width: frame.width/2.0, height: frame.height/2.0)
            gradientLayer2.colors = [UIColor.orange.cgColor,UIColor.yellow.cgColor]
            gradientLayer2.locations = [0.3,0.8,1]
            gradientLayer2.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer2.endPoint = CGPoint(x: 0, y: 1)
            glayer.addSublayer(gradientLayer2)
            
            let gradientLayer3 = CAGradientLayer.init()
            gradientLayer3.frame = CGRect(x: 0, y: frame.height/2.0, width: frame.width/2.0, height: frame.height/2.0)
            gradientLayer3.colors = [UIColor.yellow.cgColor,UIColor.green.cgColor]
            gradientLayer3.locations = [0.3,0.8]
            gradientLayer3.startPoint = CGPoint(x: 1, y: 1)
            gradientLayer3.endPoint = CGPoint(x: 0.5, y: 0)
            glayer.addSublayer(gradientLayer3)
            
            let gradientLayer4 = CAGradientLayer.init()
            gradientLayer4.frame = CGRect(x: 0, y: 0, width: frame.width/2.0 - lineW/2, height: frame.height/2.0)
            gradientLayer4.colors = [UIColor.green.cgColor,UIColor.blue.cgColor]
            gradientLayer4.startPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer4.endPoint = CGPoint(x: 0.5, y: 0)
            glayer.addSublayer(gradientLayer4)
            
        }
        
    }
    
    private lazy var progressLayer:CAShapeLayer = {
        let prLayer = CAShapeLayer.init()
        prLayer.frame = self.bounds
        prLayer.fillColor = UIColor.clear.cgColor
        prLayer.strokeColor = UIColor.white.cgColor
        prLayer.fillRule = CAShapeLayerFillRule.evenOdd
        prLayer.lineCap = CAShapeLayerLineCap.round
        prLayer.lineWidth = self.lineW
        prLayer.opacity = 1
        
        return prLayer
    }()
    
    private let glayer = CALayer.init()
    
    lazy private var textLabel:UILabel = {
        let label = UILabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.red
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        glayer.frame = bounds
        layer.addSublayer(glayer)
        
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
        
        bezierPath.addArc(withCenter:center, radius: rect.width/2 - lineW, startAngle: radiansAngle(progressAngle), endAngle: radiansAngle(-90), clockwise: false)
        
        progressLayer.path = bezierPath.cgPath
        glayer.mask = progressLayer
        
        context.addPath(bezierPath.cgPath)
        context.strokePath()
        
    }
    
    private func radiansAngle(_ angle:CGFloat)->CGFloat{
        return angle / 180.0 * .pi
    }
}
