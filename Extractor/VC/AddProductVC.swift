//
//  AddProductVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit
import LZViewPager
import PanModal
class AddProductVC: UIViewController,LZViewPagerDelegate, LZViewPagerDataSource, PanModalPresentable   {

    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var product_name: UILabel!
    @IBOutlet weak var product_amount: UILabel!
    @IBOutlet weak var product_label: UILabel!
    @IBOutlet weak var viewPager: LZViewPager!
    var productimage: UIImage!
    
    private var subControllers:[UIViewController] = []
    var button_titleString : [String] = ["Overview", "Ingredients", "Nurition"]
    var panScrollable: UIScrollView? {
        return nil
    }
//    var shortFormHeight: PanModalHeight {
//        return .contentHeight(300)
//    }
//    
//    var longFormHeight: PanModalHeight {
//        return .maxHeightWithTopInset(40)
//    }
    
    var topOffset: CGFloat {
        return 50.0
    }
    
    var springDamping: CGFloat {
        return 1.0
    }
    
    var transitionDuration: Double {
        return 0.4
    }
    
    var transitionAnimationOptions: UIView.AnimationOptions {
        return [.allowUserInteraction, .beginFromCurrentState]
    }
    
    var shouldRoundTopCorners: Bool {
        return true
    }
    
    var showDragIndicator: Bool {
        return true
    }
    
    @IBOutlet weak var scan_lbl: UILabel!
    
    @IBOutlet weak var scan_resultview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.LoadData()
        // Do any additional setup after loading the view.
    }
    func LoadData(){
        self.product_image.image = productimage
        let processor = ScaledElementProcessor()
        processor.process(in: self.product_image) { text in
            print(text)
//            self.showAlert(text)
            self.scan_resultview.text = text
            
        }
    }
    func initUI(){
        viewPager.dataSource = self
        viewPager.delegate = self
        viewPager.hostController = self
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "addoverviewVC") as! AddOverViewVC
        vc1.product_imagedata = self.productimage
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "addingredientsVC") as! AddIngredientsVC
        let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "addnuritionVC") as! AddNuritionVC
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
