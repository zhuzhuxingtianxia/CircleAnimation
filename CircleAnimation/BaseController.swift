//
//  BaseController.swift
//  CircleAnimation
//
//  Created by Jion on 2017/6/2.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    private lazy var btn:UIButton = {
        let btn = UIButton.init(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.brown
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("绘制", for: .normal)
        btn.addTarget(self, action: #selector(drawRingClick(sender:)), for: .touchUpInside)
        return btn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        buildingView()
    }

    func buildingView() {
        
        view.addSubview(btn)
        
        //垂直方向调整
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[btn]", options: NSLayoutConstraint.FormatOptions.alignAllLeft, metrics: ["top": 44+44], views: ["btn":btn]))
        //设置水平宽度
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[btn(100)]", options: NSLayoutConstraint.FormatOptions.alignAllLeft, metrics: nil, views: ["btn":btn]))
        //设置水平居中
        view.addConstraint(NSLayoutConstraint.init(item: btn, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0))
    }
    
    @objc func drawRingClick(sender: UIButton){
        
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
