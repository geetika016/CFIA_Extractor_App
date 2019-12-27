//
//  AddViewVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit
class AddViewVC: UIViewController {


    //    var shortFormHeight: PanModalHeight {
    //        return .contentHeight(300)
    //    }
    //
    //    var longFormHeight: PanModalHeight {
    //        return .maxHeightWithTopInset(40)
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false

        // Do any additional setup after loading the view.
    }
    @IBAction func Open_AddProductView(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addproductVC") as! AddProductVC
        presentPanModal(vc)
    }
}
