//
//  ArcView.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/6.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class BgArcView: UIView {
    
    //步数
    public var stepNumber:NSInteger = 0 {
        didSet{
            
            let oldNumber = UserDefaults.standard.object(forKey: "stepNumber")
            var oldStepNumber:NSInteger = 0
            
            if oldNumber == nil {
                oldStepNumber = stepNumber
            }else{
                oldStepNumber = oldNumber as! NSInteger
            }
            
            if oldStepNumber > stepNumber {
                
                totalProgress = 100 * CGFloat(stepNumber)/CGFloat(oldStepNumber)
                
            }else{
                totalProgress = 100.0
            }
            
            UserDefaults.standard.set(NSNumber.init(value: stepNumber) , forKey: "stepNumber")
            
            
            let millis:Int = Int(1.0 * 1000.0 / totalProgress)
            customTimerSource(milliseconds: millis)
            
            //从减去一最高位的地方开始累加
            let random = reduceNumber(aNumber: stepNumber)
            
            guard stepNumber > 0 else {
                return
            }
            arcView.step = stepNumber - random!
            let milliseconds:Int = 1*1000/random!
            textTimerSource(milliseconds: milliseconds)
        }
    }

    //默认环宽
    public var ringWidth:CGFloat = 10.0
    //默认环色
    public var ringColor = UIColor.white
    
    //半径
    private var radius:CGFloat = 0
    
    //定时器
    private var timer:DispatchSourceTimer?
    //定时器
    private var textTimer:DispatchSourceTimer?
    
    private let prLayer:CAShapeLayer = {
        let prLayer = CAShapeLayer.init()
        prLayer.fillColor = UIColor.clear.cgColor
        prLayer.strokeColor = UIColor.white.cgColor
        prLayer.fillRule = CAShapeLayerFillRule.evenOdd
        prLayer.lineCap = CAShapeLayerLineCap.round
        prLayer.lineWidth = 10
        prLayer.opacity = 1

        return prLayer
    }()
    
    private let glayer = CALayer.init()
    
    private var  arcView:ArcView = ArcView.init()
    //总进度
    private var totalProgress:CGFloat = 0
    
    //MARK:- 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        //此半径是圆心到圆环中心的距离
        radius = frame.width/2.0 - ringWidth/2.0
        
        
        prLayer.frame = self.bounds
        let bezierPath = UIBezierPath.init()
        //不同的坐标系 clockwise显示的不同
        bezierPath.addArc(withCenter: CGPoint.init(x: frame.width/2, y:frame.height/2), radius: radius, startAngle: (1/2 + 1/4) * .pi, endAngle: (1/2 - 1/4) * .pi, clockwise: true)
        
        prLayer.path = bezierPath.cgPath
        
        
        
        glayer.frame = bounds
        //设置固定圆环背景色
        glayer.backgroundColor = UIColor.init(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1.0).cgColor
        glayer.mask = prLayer
        
        layer.addSublayer(glayer)
        
        //添加子视图
        arcView.frame = bounds
        arcView.ringWidth = ringWidth
        
        self.addSubview(arcView)
        
    }
    
    
    required  init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func reduceNumber(aNumber:NSInteger) -> NSInteger? {
        let strNumber = String(aNumber)
        let len = strNumber.count
        if len < 3 {
            return 1
        }else{
            var string:String = "1"
            if strNumber.hasPrefix("1") {
                for _ in 0..<(len - 2) {
                  string = string.appending("0")
                }
            }else{
                for _ in 0..<(len - 1) {
                   string = string.appending("0")
                }
            }
            
            
            return NSInteger(string)
        }
        
    }
    
    //定时器
    private func customTimerSource(milliseconds: Int){
        //GCD创建定时器
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        //设置参数，设定开始的时间，间隔的时间
        //microseconds微秒 milliseconds毫秒 nanoseconds纳秒
        timer?.scheduleRepeating(deadline: DispatchTime.now(), interval: DispatchTimeInterval.milliseconds(milliseconds))
        
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
        
        arcView.progress = arcView.progress + 1
        print("===\(String(describing: arcView.progress))")
        if arcView.progress >= totalProgress {
            arcView.progress = totalProgress
            timer?.cancel()
        }
    }
    
    private func textTimerSource(milliseconds: Int){
        //GCD创建定时器
        textTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        //设置参数，设定开始的时间，间隔的时间
        //microseconds微秒 milliseconds毫秒 nanoseconds纳秒
        textTimer?.scheduleRepeating(deadline: DispatchTime.now(), interval: DispatchTimeInterval.milliseconds(milliseconds))
        
        //设定要执行的事件
        textTimer?.setEventHandler {
            //查看当前的线程
            // print("\(Thread.current)")
            DispatchQueue.main.async {
                
                //定时器启动，进度加载
                self.textAnimationLoad()
                
            }
        }
        //继续执行
        textTimer?.resume()
    }

    private func textAnimationLoad(){
        
        arcView.step = arcView.step + 1
        print("===\(String(describing: arcView.step))")
        if arcView.step >= stepNumber {
            arcView.step = stepNumber
            textTimer?.cancel()
        }
    }
    


}

//========================
 private class ArcView: UIView {
    
    //步数
    public var step:NSInteger = 0 {
        
        didSet{
            textLabel.text = "\(step)"
            textLabel.sizeToFit()
        }
    }
    //进度
    public var progress:CGFloat = 0.0 {
        didSet{
            if progress >= 100.0 {
                progress = 100.0
            }
            setNeedsDisplay()
        }
    }
    //颜色数组
    public var colors:Array = [UIColor.yellow.cgColor,UIColor.orange.cgColor]

    public var ringWidth:CGFloat = 0.0 {
        didSet{
            radius = min(frame.width, frame.height)/2.0
        }
    }
    lazy private var textLabel:UILabel = {
        let label = UILabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.red
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        label.text = "--"
        return label
    }()
    
    private var radius:CGFloat = 0
    
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
        
        let progressAngle = localProgress * 270.0 - 180 - 45
        let center = CGPoint.init(x: rect.width/2.0, y: rect.height/2.0)
        
        let bezierPath = UIBezierPath.init()
        //参数说明：第一个圆心坐标，第二个半径大小，第三个起始角度，第四个结束角度，第五个是否顺时针方向
        bezierPath.append(UIBezierPath.init(arcCenter: center, radius: radius, startAngle: radiansAngle(135), endAngle: radiansAngle(progressAngle), clockwise: true))
        
        
        var endPoint:CGPoint = CGPoint.init()
        endPoint.x = (cos(radiansAngle(progressAngle)) * (radius - ringWidth/2)) + center.x
        endPoint.y = (sin(radiansAngle(progressAngle)) * (radius - ringWidth/2)) + center.y
        
        bezierPath.addArc(withCenter: endPoint, radius: ringWidth/2, startAngle: radiansAngle(progressAngle), endAngle: radiansAngle(270.0 + progressAngle - 90.0), clockwise: true)
 
        bezierPath.addArc(withCenter: center, radius: radius - ringWidth, startAngle: radiansAngle(progressAngle), endAngle: radiansAngle(135), clockwise: false)
        
        var beginPoint:CGPoint = CGPoint.init()
        beginPoint.x = (cos(radiansAngle(135)) * (radius - ringWidth/2)) + center.x
        beginPoint.y = (sin(radiansAngle(135)) * (radius - ringWidth/2)) + center.y
        
        bezierPath.addArc(withCenter: beginPoint, radius: ringWidth/2, startAngle: radiansAngle(0), endAngle: radiansAngle(180), clockwise: true)
 
        //用于裁剪多余部分（例如修剪成圆形）
        bezierPath.addClip()
        
        //梯度1
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let backgroundColors1 = colors
        
        let backgroudColorLocations1:[CGFloat] = [0.2, 0.8]
        let backgroundGradient1 = CGGradient.init(colorsSpace: colorSpace, colors: backgroundColors1 as CFArray, locations: backgroudColorLocations1)
        context.drawLinearGradient(backgroundGradient1!, start: CGPoint.init(x: 0, y: rect.height/2), end: CGPoint.init(x: rect.width, y: rect.height/2), options: CGGradientDrawingOptions(rawValue: 0))
        
        bezierPath.close()
        context.restoreGState()
        
    }

    private func radiansAngle(_ angle:CGFloat)->CGFloat{
        return angle / 180.0 * .pi
    }
}

