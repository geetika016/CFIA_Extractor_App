//
//  OverViewVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class OverViewVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var product_barcodelbl: UILabel!
    
    @IBOutlet weak var product_status: UILabel!
    var pr_barcode: String = "0067568110909"
    var pr_status: String = "Complaint"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.product_barcodelbl.text = self.pr_barcode
        self.product_status.text = self.pr_status
        
    }
    
    @IBAction func Edit_productInfo(_ sender: Any) {
        
    }
    
    @IBAction func Add_productImage(_ sender: Any) {
       // self.SelectPhoto()
    }
  
        
}
