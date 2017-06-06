//
//  ViewController.swift
//  CircleAnimation
//
//  Created by Jion on 2017/5/27.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let dataArray:Array = ["弧形","扇形","环形","环形过滤","梯度效果","多梯度效果","梯度环形(效果不好)","Layer梯度","Layer环梯度","梯度环形优化","支付宝运动步数"]
    
    private lazy var tabelView:UITableView = {
        let table:UITableView = UITableView.init(frame: self.view.frame, style: .plain)
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table;
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     title = "图形效果"
      view.addSubview(tabelView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = dataArray[indexPath.row]
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var test1:UIViewController?
        
        switch indexPath.row {
        case 0:
            test1 = Test1Controller()
        case 1:
            test1 = Test2Controller()
        case 2:
            test1 = Test3Controller()
        case 3:
            test1 = Test4Controller()
        case 4:
            test1 = Test5Controller()
        case 5:
            test1 = Test6Controller()
        case 6:
            test1 = Test7Controller()
        case 7:
            test1 = Test8Controller()
        case 8:
            test1 = Test9Controller()
        case 9:
            test1 = RingController()
        case 10:
            test1 = ArcController()
        default: break
            
        }
        
        test1!.title = dataArray[indexPath.row]
        navigationController?.pushViewController(test1!, animated: true)
        
        
    }
    
}



