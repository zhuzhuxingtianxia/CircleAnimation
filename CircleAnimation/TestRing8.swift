//
//  TestRing8.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/6.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class TestRing8: UIView {
  //采用Layer
     
    private let glayer = CALayer.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        glayer.frame = bounds
        
        let gradientLayer1 = CAGradientLayer.init()
        
        gradientLayer1.frame = CGRect(x: frame.width/2.0, y: 0, width: frame.width/2.0, height: frame.height/2.0)
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
        gradientLayer4.frame = CGRect(x: 0, y: 0, width: frame.width/2.0, height: frame.height/2.0)
        gradientLayer4.colors = [UIColor.green.cgColor,UIColor.blue.cgColor]
        gradientLayer4.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer4.endPoint = CGPoint(x: 0.5, y: 0)
        glayer.addSublayer(gradientLayer4)
        
        layer.addSublayer(glayer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect){
    
        
    }
    
    
}
