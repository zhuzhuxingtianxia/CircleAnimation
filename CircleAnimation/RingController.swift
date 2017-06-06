//
//  RingController.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/2.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class RingController: BaseController {
    
    var ring:RingView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    
    
    override func drawRingClick(sender: UIButton) {
        ring = RingView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        ring.ringWidth = 10
        ring.center = view.center
        ring.backgroundColor = UIColor.white
        
        view.addSubview(ring)
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
