//
//  NuritionVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class NuritionVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    
    @IBOutlet weak var product_ImageView: UIImageView!
    @IBOutlet weak var product_InfoListView: UITableView!
    var sampleDataTypes: [String] = ["Calories","Fat/Lipides", "Sodium", "Carbohydrate","Protein"]
     var sampleDataDetails: [String] = ["0", "0 g", "590 mg", "0 g", "0 g"]
    var productData  = NSDictionary()
    var historyFlag = 0
    var historyData = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        if (self.historyFlag == 0){
               self.LoadData()
        }else {
            self.LoadHistoryData()
        }
     
        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.product_InfoListView.dataSource = self
        self.product_InfoListView.delegate = self
    }
    func LoadHistoryData(){
        let imageurl = historyData["image_nutrition_url"] as! String
        self.product_ImageView.moa.url = imageurl
        self.sampleDataTypes = historyData["sampleDataTypes"] as! [String]
        self.sampleDataDetails = historyData["sampleDataDetails"] as! [String]
        self.product_InfoListView.reloadData()
    }
    func LoadData(){
        if let imageurl = productData["image_nutrition_url"] as? String {
            self.product_ImageView.moa.url = imageurl
        }else{
            if let imageurl = productData["image_nutrition_small_url"] as? String {
                self.product_ImageView.moa.url = imageurl
            }else {
                if let imageurl = productData["image_nutrition_thumb_url"] as? String {
                    self.product_ImageView.moa.url = imageurl
                }else{
                    
                }
            }
        }
        if let nutriments = productData["nutriments"] as? NSDictionary {
            self.sampleDataTypes.removeAll()
            self.sampleDataDetails.removeAll()
            let keys = nutriments.allKeys as! [String]
            for index1 in 0..<keys.count {
                let eachkey = keys[index1] as! String
                if (eachkey.contains("_")){
                    
                }else{
                    self.sampleDataTypes.append(eachkey)
                    let otherkey = eachkey + "_100g"
                    print(eachkey)
                    if let key_value = nutriments[otherkey] as? String {
                        let key_valuestr = String(key_value) as! String
                        print(key_value)
                        if let key_unit = nutriments[eachkey + "_unit"] as? String {
                            let details = key_valuestr + " " + key_unit
                            self.sampleDataDetails.append(details)
                        }else{
                            let details = key_valuestr
                            self.sampleDataDetails.append(details)
                        }
                       
                    }else{
                        if let key_value1 = nutriments[otherkey] as? Double {
                             print(key_value1)
                            let key_valuestr1 = String(key_value1) as! String
                            if let key_unit1 = nutriments[eachkey + "_unit"] as? String {
                                let details1 = key_valuestr1 + " " + key_unit1
                                self.sampleDataDetails.append(details1)
                            }else{
                                let details1 = key_valuestr1
                                self.sampleDataDetails.append(details1)
                            }
                            
                        }else{
                            self.sampleDataDetails.append("0")
                        }
                       
                    }
                }
            }
        }else{
            self.sampleDataTypes.removeAll()
            self.sampleDataDetails.removeAll()
        }
        self.product_InfoListView.reloadData()
        
    }
    @IBAction func Add_ProductPhoto(_ sender: Any) {
        
    }
    
   
}
extension NuritionVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sampleDataTypes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nuritionCell", for: indexPath) as! NuritionCell
        
        cell.datatype_Lbl.text = self.sampleDataTypes[indexPath.row]
        cell.datadetails_Lbl.text = self.sampleDataDetails[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}
