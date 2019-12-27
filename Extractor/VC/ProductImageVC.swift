//
//  ProductImageVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class ProductImageVC: UIViewController {

    @IBOutlet weak var product_ImageView: UIImageView!
    var product_image: UIImage!
    
    @IBOutlet weak var bottom_View: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.LoadData()
    }
    func LoadData(){
        self.product_ImageView.image = self.product_image
        let processor = ScaledElementProcessor()
        processor.process(in: self.product_ImageView) { text in
            print(text)
            //self.showAlert(text)
        }
    }
    func initUI(){
        let title_view = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        title_view.textColor = .white
        title_view.text = "New Product!"
        title_view.font = UIFont.boldSystemFont(ofSize: 20)
        title_view.textAlignment = .center
        navigationItem.titleView = title_view
        let navBarColor = UIColor.init(red: 48/255, green: 48/255, blue: 54/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = navBarColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.bottom_View.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    
    @IBAction func Open_AddProductView(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addproductVC") as! AddProductVC
        vc.productimage = self.product_image
        presentPanModal(vc)
    }
    
}
