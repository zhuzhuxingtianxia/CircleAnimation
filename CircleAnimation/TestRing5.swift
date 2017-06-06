//
//  TestRing5.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/5.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class TestRing5: UIView {

    //颜色过渡根据起始点，默认自上而下（0.5，0）->(0.5,1)，若start(0,0)->end(1,1)则成对角线分布
    
    override func draw(_ rect: CGRect){
        let context = UIGraphicsGetCurrentContext()!
        
        //创建颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //设置过渡色颜色数组
        let backgroundColors = [UIColor.red.cgColor,UIColor.orange.cgColor,UIColor.yellow.cgColor];
        //设置渐变区域(必须是单调递增的)
        let backgroudColorLocations:[CGFloat] = [0.2, 0.5 ,0.8]
        //设置颜色过滤器
        let backgroundGradient = CGGradient.init(colorsSpace: colorSpace, colors: backgroundColors as CFArray, locations: backgroudColorLocations)
        
        //start、end梯度变化的起,始点 
        //设置start(0,0),end(rect.width,rect.height)看是什么效果
        context.drawLinearGradient(backgroundGradient!, start: CGPoint.init(x: rect.width/2, y: 0), end: CGPoint.init(x: rect.width/2, y: rect.height), options: CGGradientDrawingOptions.drawsBeforeStartLocation)
    
    }


}
