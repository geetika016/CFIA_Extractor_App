//
//  IngredientsVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class IngredientsVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var product_ImageView: UIImageView!
    @IBOutlet weak var product_InfoListview: UITableView!
    
    var infotypes : [String] = ["List of ingredients", "Substances or products causing allergies or intolerances", "Non compliant ingredients"]
    var infodetails: [String] = ["Salt, calcium,silicate,sodium thissulphate, potassium iodide,sodium bicarbonate", "NA", "NA"]
    var productData = NSDictionary()
    var historyFlag = 0
    var historyData = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        if (self.historyFlag == 0){
             self.LoadData()
        }else{
            self.LoadHistoryData()
        }
       // Do any additional setup after loading the view.
    }
    func initUI(){
        self.product_InfoListview.delegate = self
        self.product_InfoListview.dataSource = self
    }
    func LoadHistoryData(){
       let imageurl = historyData["image_ingredients_url"] as! String
       self.product_ImageView.moa.url = imageurl
       infodetails = historyData["infodetails"] as! [String]
        
        self.product_InfoListview.reloadData()
    }
    func LoadData(){
        if let imageurl = productData["image_ingredients_url"] as? String {
            self.product_ImageView.moa.url = imageurl
        }else{
            if let imageurl = productData["image_ingredients_small_url"] as? String {
                self.product_ImageView.moa.url = imageurl
            }else {
                if let imageurl = productData["image_ingredients_thumb_url"] as? String {
                    self.product_ImageView.moa.url = imageurl
                }else{
                    
                }
            }
        }
        self.infodetails.removeAll()
        if let ingreditents = productData["ingredients_text"] as? String {
            self.infodetails.append(ingreditents)
        }else {
              self.infodetails.append("")
        }
        if let substance = productData["intolerances"] as? String {
            self.infodetails.append(substance)
        }else{
            self.infodetails.append("")
        }
        if let non_complaint = productData["compliant"] as? String {
            self.infodetails.append(non_complaint)
        }else{
            self.infodetails.append("")
        }
        self.product_InfoListview.reloadData()
        
    }

    @IBAction func Add_productPhoto(_ sender: Any) {
       
    }
    
    
}
extension IngredientsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingrdientCell", for: indexPath) as! IngredientCell
        cell.info_type.text = self.infotypes[indexPath.row]
        cell.info_details.text = self.infodetails[indexPath.row]
        return cell
    }
}
