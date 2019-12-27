//
//  HistoryDetailVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit
import LZViewPager
class HistoryDetailVC: UIViewController,LZViewPagerDelegate, LZViewPagerDataSource {
    @IBOutlet weak var viewPager: LZViewPager!
    private var subControllers:[UIViewController] = []
    var button_titleString : [String] = ["Overview", "Ingredients", "Nurition"]
    var historyData = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        viewPager.dataSource = self
        viewPager.delegate = self
        viewPager.hostController = self
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "searchoverviewVC") as! SearchOverViewVC
        vc1.historyData = self.historyData
        vc1.historyFlag = 1
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ingredientsVC") as! IngredientsVC
        vc2.historyFlag = 1
        vc2.historyData = self.historyData
        let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "nuritionVC") as! NuritionVC
        vc3.historyFlag = 1
        vc3.historyData = self.historyData
        self.subControllers = [vc1,vc2,vc3]
        viewPager.reload()
        
    }
    func numberOfItems() -> Int {
        return self.subControllers.count
    }
    func controller(at index: Int) -> UIViewController {
        return subControllers[index]
    }
    func button(at index: Int) -> UIButton {
        //Customize your button styles here
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle(self.button_titleString[index], for: .normal)
        button.backgroundColor = .groupTableViewBackground
        return button
    }
    func widthForIndicator(at index: Int) -> CGFloat {
        return self.view.frame.width / 3 - 30
    }
    func colorForIndicator(at index: Int) -> UIColor {
        return .blue
    }
    func backgroundColorForHeader() -> UIColor {
        return .groupTableViewBackground
    }
}
