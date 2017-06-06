//
//  Test4Controller.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/5.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class Test4Controller: BaseController {

    private var timer:DispatchSourceTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func drawRingClick(sender: UIButton){
        let testRing = TestRing4.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        testRing.center = view.center
        testRing.backgroundColor = UIColor.yellow
        view.addSubview(testRing)
        
        customTimerSource(testRing: testRing)
    }
    //定时器1
    private func customTimerSource(testRing:TestRing4){
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
                self.radianAnimationLoad(testRing: testRing)
                
            }
        }
        //继续执行
        timer?.resume()
    }
    
    private func radianAnimationLoad(testRing:TestRing4){
        
        testRing.progress = testRing.progress + 1.0
        print("===\(String(describing: testRing.progress))")
        if testRing.progress >= 100.0 {
            timer?.cancel()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
