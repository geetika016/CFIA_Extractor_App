//
//  ScanResultVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit
import LZViewPager
import PanModal
class ScanResultVC: UIViewController,LZViewPagerDelegate, LZViewPagerDataSource,PanModalPresentable  {
    
    
    
    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var product_labelLbl: UILabel!
    @IBOutlet weak var product_nameLbl: UILabel!
    @IBOutlet weak var product_amount: UILabel!
    
    
    @IBOutlet weak var viewPager: LZViewPager!
    private var subControllers:[UIViewController] = []
    var productData = NSDictionary()
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.LoadData()
        self.Data_Process()
        // Do any additional setup after loading the view.
    }
    func LoadData(){
        let imageurl = productData["image_url"] as! String
        let prodcut_namestr = productData["product_name"] as! String
        let product_amountstr = productData["quantity"] as! String
        let product_brandsstr = productData["brands"] as! String
        self.product_image.moa.url = imageurl
        self.product_nameLbl.text = prodcut_namestr
        self.product_labelLbl.text = product_brandsstr
        self.product_amount.text = product_amountstr
       
        
        
    }
    func Data_Process(){
        var imageurl6 = productData["image_url"] as! String
        var prodcut_namestr : String = ""
        var  product_amountstr : String = ""
        var product_brandsstr : String = ""
        
        if let imageurl61 = productData["image_url"] as? String {
            //self.keyvalueArray.append(barcode)
            imageurl6 = imageurl61
        }else{
            ///self.keyvalueArray.append("")
            imageurl6 = ""
        }
        
        if let prodcut_namestr1 = productData["product_name"] as? String {
            //self.keyvalueArray.append(barcode)
            prodcut_namestr = prodcut_namestr1
        }else{
            ///self.keyvalueArray.append("")
            prodcut_namestr = ""
        }
        
        if let product_amountstr1 = productData["quantity"] as? String {
            //self.keyvalueArray.append(barcode)
            product_amountstr = product_amountstr1
        }else{
            ///self.keyvalueArray.append("")
            product_amountstr = ""
        }
        
        if let product_brandsst1 = productData["brands"] as? String {
            //self.keyvalueArray.append(barcode)
            product_brandsstr = product_brandsst1
        }else{
            ///self.keyvalueArray.append("")
            product_brandsstr = ""
        }
        
        var barcode : String = ""
        if let barcode1 = productData["id"] as? String {
            //self.keyvalueArray.append(barcode)
            barcode = barcode1
        }else{
            ///self.keyvalueArray.append("")
            barcode = ""
        }
        var packaging : String = ""
        if let packaging1 = productData["packaging"] as? String {
            packaging = packaging1
        }else{
            packaging = ""
        }
        var manufacture : String = ""
        if let manufacture1 = productData["manufacturing_places"] as? String {
            manufacture = manufacture1
        }else{
            manufacture = ""
        }
        var category : String = ""
        if let category1 = productData["categories"] as? String {
            category = category1
        }else{
            category = ""
        }
        var infodetails: [String] = []
        if let ingreditents = productData["ingredients_text"] as? String {
            infodetails.append(ingreditents)
        }else {
            infodetails.append("")
        }
        if let substance = productData["intolerances"] as? String {
            infodetails.append(substance)
        }else{
            infodetails.append("")
        }
        if let non_complaint = productData["compliant"] as? String {
            infodetails.append(non_complaint)
        }else{
            infodetails.append("")
        }
        var sampleDataTypes: [String] = []
        var sampleDataDetails: [String] = []
        if let nutriments = productData["nutriments"] as? NSDictionary {
            
            let keys = nutriments.allKeys as! [String]
            for index1 in 0..<keys.count {
                let eachkey = keys[index1] as! String
                if (eachkey.contains("_")){
                    
                }else{
                    sampleDataTypes.append(eachkey)
                    let otherkey = eachkey + "_100g"
                    print(eachkey)
                    if let key_value = nutriments[otherkey] as? String {
                        let key_valuestr = String(key_value) as! String
                        print(key_value)
                        if let key_unit = nutriments[eachkey + "_unit"] as? String {
                            let details = key_valuestr + " " + key_unit
                            sampleDataDetails.append(details)
                        }else{
                            let details = key_valuestr
                            sampleDataDetails.append(details)
                        }
                        
                    }else{
                        if let key_value1 = nutriments[otherkey] as? Double {
                            print(key_value1)
                            let key_valuestr1 = String(key_value1) as! String
                            if let key_unit1 = nutriments[eachkey + "_unit"] as? String {
                                let details1 = key_valuestr1 + " " + key_unit1
                                sampleDataDetails.append(details1)
                            }else{
                                let details1 = key_valuestr1
                                sampleDataDetails.append(details1)
                            }
                            
                        }else{
                            sampleDataDetails.append("0")
                        }
                    }
                    
                }
            }
        }else{
            sampleDataTypes.removeAll()
            sampleDataDetails.removeAll()
        }
        var imageurl1 : String = ""
        if let imageurl = productData["image_nutrition_url"] as? String {
            imageurl1 = imageurl
        }else{
            if let imageurl = productData["image_nutrition_small_url"] as? String {
                imageurl1 = imageurl
            }else {
                if let imageurl = productData["image_nutrition_thumb_url"] as? String {
                    imageurl1 = imageurl
                }else{
                    
                }
            }
        }
        var imageurl2 : String = ""
        if let imageurl4 = productData["image_ingredients_url"] as? String {
            imageurl2 = imageurl4
        }else{
            if let imageurl4 = productData["image_ingredients_small_url"] as? String {
                imageurl2 = imageurl4
            }else {
                if let imageurl4 = productData["image_ingredients_thumb_url"] as? String {
                    imageurl2 = imageurl4
                }else{
                    
                }
            }
        }
        
        let saved_datas : [String: Any] = ["image_url" : imageurl6 ,"product_name" : prodcut_namestr, "quantity" : product_amountstr, "brands" : product_brandsstr, "barcode" : barcode, "packaging" : packaging, "manufacture" : manufacture, "category" : category, "infodetails" : infodetails, "sampleDataTypes" : sampleDataTypes, "sampleDataDetails" : sampleDataDetails,"image_nutrition_url" : imageurl1,"image_ingredients_url" : imageurl2]
        let timestamp = Int(NSDate().timeIntervalSince1970) as! Int
        
        
        let history_data : [String: Any] = ["timestamp" : timestamp, "product": saved_datas]
        var inputdatas = NSMutableArray()
        inputdatas.add(history_data)
        for index in 0..<AppData.shared.historyData.count {
            let eachdata = AppData.shared.historyData[index] as! NSDictionary
            inputdatas.add(eachdata)
        }
        AppData.shared.historyData = NSMutableArray()
        AppData.shared.historyData = inputdatas
        print(inputdatas)
        let save_datas : [String : Any] = ["history_data" : AppData.shared.historyData]
        UserDefaults.standard.set(save_datas, forKey: "saved_productDatas")
        
    }
    func initUI(){
        viewPager.dataSource = self
        viewPager.delegate = self
        viewPager.hostController = self
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "searchoverviewVC") as! SearchOverViewVC
        vc1.viewData = self.productData
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "ingredientsVC") as! IngredientsVC
        vc2.productData = self.productData
        let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "nuritionVC") as! NuritionVC
        vc3.productData = self.productData
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
