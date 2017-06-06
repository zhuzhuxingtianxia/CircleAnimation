//
//  RingView.swift
//  CircleAnimation
//
//  Created by Jion on 2017/5/27.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit


class RingView: UIView {

    //默认环宽
    public var ringWidth:CGFloat = 10.0
    //默认环色
    public var ringColor = UIColor.white
    //动态环默认颜色
    public var radianColor = UIColor.orange
    //半径
    private var radius:CGFloat = 0
    
    //运动弧
    private var radianView:RadianView!
    /*
     定时器,
     timer需要定义全局的，
     否则函数执行完毕则会把对象释放
     */
    private var timer:DispatchSourceTimer?
    
    //MARK:- 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        //此半径是圆心到圆环中心的距离
        radius = frame.width/2.0 - ringWidth/2.0
        
        showSubUI()
    }
    required  init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //添加子视图
    private func showSubUI(){
        radianView = RadianView.init(frame: frame)
        radianView.ringWidth = ringWidth
        
        self.addSubview(radianView)
        
        customTimerSource()
    }
    
    //定时器
    private func customTimerSource(){
        //GCD创建定时器
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        //设置参数，设定开始的时间，间隔的时间 
        //microseconds微秒 milliseconds毫秒 nanoseconds纳秒
        timer?.scheduleRepeating(deadline: DispatchTime.now(), interval: DispatchTimeInterval.milliseconds(50))
        
        //设定要执行的事件
        timer?.setEventHandler {
            //查看当前的线程
           // print("\(Thread.current)")
            DispatchQueue.main.async {
                
                //定时器启动，进度加载
                self.radianAnimationLoad()
                
            }
        }
        //继续执行
        timer?.resume()
    }
    
    private func radianAnimationLoad(){
        
        radianView.progress = radianView.progress + 1.0
        print("===\(String(describing: radianView.progress))")
        if radianView.progress >= 100.0 {
            timer?.cancel()
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()!
        //设置阴影,偏移量
        //context.setShadow(offset: CGSize.init(width: -5.0, height: -1.0), blur: 0.5, color: UIColor.orange.cgColor)
        //设置缓冲区，色值
        context.setStrokeColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0)
        
        context.setLineWidth(ringWidth)
        
        context.addArc(center: CGPoint.init(x: rect.width/2, y: rect.height/2), radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: false)
        
        context.drawPath(using: CGPathDrawingMode.stroke)
        
    }

}


//****动画圆环*****//

private class RadianView: UIView{
    
    public var ringWidth:CGFloat = 0.0 {
        didSet{
            radius = min(frame.width, frame.height)/2.0
        }
    }
    //进度
    public var progress:CGFloat = 0.0 {
        didSet{
            textLabel.text = "\(progress)"
            textLabel.sizeToFit()
            setNeedsDisplay()
        }
    }
    
    private var radius:CGFloat = 0
    
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
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
        let localProgress = min(1.0, max(0.0,  progress/100.0))
        
        let progressAngle = localProgress * 360.0 - 90
        let center = CGPoint.init(x: rect.width/2.0, y: rect.height/2.0)
        
        let bezierPath = UIBezierPath.init()
        //参数说明：第一个圆心坐标，第二个半径大小，第三个起始角度，第四个结束角度，第五个是否顺时针方向
        bezierPath.append(UIBezierPath.init(arcCenter: center, radius: radius, startAngle: radiansAngle(-90), endAngle: radiansAngle(progressAngle), clockwise: true))
        
        let roundedFooder:Bool = localProgress < 1.0 ? true:false
        if roundedFooder==true {
            var point:CGPoint = CGPoint.init()
            point.x = (cos(radiansAngle(progressAngle)) * (radius - ringWidth/2)) + center.x
            point.y = (sin(radiansAngle(progressAngle)) * (radius - ringWidth/2)) + center.y
            
            bezierPath.addArc(withCenter: point, radius: ringWidth/2, startAngle: radiansAngle(progressAngle), endAngle: radiansAngle(270.0 + progressAngle - 90.0), clockwise: true)
            
        }
        
        bezierPath.addArc(withCenter: center, radius: radius - ringWidth, startAngle: radiansAngle(progressAngle), endAngle: radiansAngle(-90), clockwise: false)
        
        let roundedHead:Bool = localProgress < 0.98 ? true:false
        if roundedHead == true {
            var point:CGPoint = CGPoint.init()
            point.x = (cos(radiansAngle(-90)) * (radius - ringWidth/2)) + center.x
            point.y = (sin(radiansAngle(-90)) * (radius - ringWidth/2)) + center.y
            
            bezierPath.addArc(withCenter: point, radius: ringWidth/2, startAngle: radiansAngle(-90), endAngle: radiansAngle(90), clockwise: false)
        }
        
        //用于裁剪多余部分（例如修剪成圆形）
        bezierPath.addClip()
        
        //梯度1
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let backgroundColors1 = [UIColor.orange.cgColor,UIColor.init(red: 250/255.0, green: 249/255.0, blue: 40/255.0, alpha: 1.0).cgColor];
        
        let backgroudColorLocations1:[CGFloat] = [0.0, 1.0]
        let backgroundGradient1 = CGGradient.init(colorsSpace: colorSpace, colors: backgroundColors1 as CFArray, locations: backgroudColorLocations1)
        if localProgress > 0.97 {
            context.drawLinearGradient(backgroundGradient1!, start: CGPoint.init(x: rect.width/2, y: 0), end: CGPoint.init(x: rect.width, y: rect.height*2/3), options: CGGradientDrawingOptions(rawValue: 0))
        }else{
           context.drawLinearGradient(backgroundGradient1!, start: CGPoint.init(x: rect.width/2 - ringWidth/2, y: 0), end: CGPoint.init(x: rect.width, y: rect.height*2/3), options: CGGradientDrawingOptions(rawValue: 0))
        }
        
        //梯度2
        let backgroundColors2 = [UIColor.green.cgColor,UIColor.yellow.cgColor];
        
        let backgroudColorLocations2:[CGFloat] = [0.0, 0.7]
        let backgroundGradient2 = CGGradient.init(colorsSpace: colorSpace, colors: backgroundColors2 as CFArray, locations: backgroudColorLocations2)
        if localProgress > 0.97 {
            context.drawLinearGradient(backgroundGradient2!, start: CGPoint.init(x: rect.width/2, y: 0), end: CGPoint.init(x: 0, y: 0), options: CGGradientDrawingOptions(rawValue: 0))
        }else{
            context.drawLinearGradient(backgroundGradient2!, start: CGPoint.init(x: rect.width/2 - ringWidth/2, y: 0), end: CGPoint.init(x: 0, y: 0), options: CGGradientDrawingOptions(rawValue: 0))
        }

        //梯度3
        let backgroundColors3 = [UIColor.init(red: 250/255.0, green: 249/255.0, blue: 40/255.0, alpha: 1.0).cgColor,UIColor.yellow.cgColor];
        
        let backgroudColorLocations3:[CGFloat] = [0.0, 1.0]
        let backgroundGradient3 = CGGradient.init(colorsSpace: colorSpace, colors: backgroundColors3 as CFArray, locations: backgroudColorLocations3)
        context.drawLinearGradient(backgroundGradient3!, start: CGPoint.init(x: 0, y: rect.height*2/3), end: CGPoint.init(x: 0, y: rect.height), options: CGGradientDrawingOptions(rawValue: 0))
       
        bezierPath.close()
        context.restoreGState()
        
    }
    
   private func radiansAngle(_ angle:CGFloat)->CGFloat{
        return angle / 180.0 * .pi
    }
    
}
