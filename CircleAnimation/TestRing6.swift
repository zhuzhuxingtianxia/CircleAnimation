//
//  TestRing6.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/5.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class TestRing6: UIView {

    //给圆环设置不同的渐变颜色，使用一个渐变过滤器看起来是不能实现的
    
    override func draw(_ rect: CGRect){
        
        let context = UIGraphicsGetCurrentContext()!
        
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
        
        let backgroudColorLocations2:[CGFloat] = [0.0 ,0.8]
        
        let backgroundGradient2 = CGGradient.init(colorsSpace: colorSpace, colors: backgroundColors2 as CFArray, locations: backgroudColorLocations2)
        
        context.drawLinearGradient(backgroundGradient2!, start: CGPoint.init(x: 0, y: 0), end: CGPoint.init(x: rect.width/2, y: 0), options: CGGradientDrawingOptions(rawValue: 0))
        
        //渐变3
        let backgroundColors3 = [UIColor.orange.cgColor]
        
        let backgroudColorLocations3:[CGFloat] = [1.0]
        
        let backgroundGradient3 = CGGradient.init(colorsSpace: colorSpace, colors: backgroundColors3 as CFArray, locations: backgroudColorLocations3)
        
        context.drawLinearGradient(backgroundGradient3!, start: CGPoint.init(x: 0, y: rect.height*3/4), end: CGPoint.init(x: 0, y: rect.height), options: CGGradientDrawingOptions(rawValue: 0))
        
    }


}
