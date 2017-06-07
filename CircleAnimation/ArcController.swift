//
//  ArcController.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/6.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class ArcController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        // Do any additional setup after loading the view.
    }

    override func drawRingClick(sender: UIButton) {
       let arcView = BgArcView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        arcView.center = view.center
        arcView.backgroundColor = UIColor.white
        arcView.stepNumber = NSInteger(arc4random()%10000)
        view.addSubview(arcView)
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
