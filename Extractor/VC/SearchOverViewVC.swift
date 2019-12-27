//
//  SearchOverViewVC.swift
//  Extractor
//
//  Created by Jin Omori on 12/1/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class SearchOverViewVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    
    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var product_name: UILabel!
    @IBOutlet weak var product_brands: UILabel!
    @IBOutlet weak var product_amount: UILabel!
    var viewData = NSDictionary()
    @IBOutlet weak var overviewListView: UITableView!
    var keywordArray : [String] = ["Barcode", "Packaging", "Manufacturing or processing places","Categories"]
    var keyvalueArray : [String] = ["","","",""]
    var historyFlag = 0
    var historyData = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        if (historyFlag == 0){
            self.LoadData()
        }else{
            self.LoadHistoryData()
        }
      //  LoadData()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        overviewListView.dataSource = self
        overviewListView.delegate = self
    }
    func LoadHistoryData(){
        let imageurl = historyData["image_url"] as! String
        let prodcut_namestr = historyData["product_name"] as! String
        let product_amountstr = historyData["quantity"] as! String
        let product_brandsstr = historyData["brands"] as! String
        self.product_image.moa.url = imageurl
        self.product_name.text = prodcut_namestr
        self.product_brands.text = product_brandsstr
        self.product_amount.text = product_amountstr
        self.keyvalueArray.removeAll()
        let barcode = historyData["barcode"] as! String
        self.keyvalueArray.append(barcode)
        let packaging = historyData["packaging"] as! String
        self.keyvalueArray.append(packaging)
        let manufacture = historyData["manufacture"] as! String
        self.keyvalueArray.append(manufacture)
        let category = historyData["category"] as! String
        self.keyvalueArray.append(category)
      
        self.overviewListView.reloadData()
    }
    func LoadData(){
        let imageurl = viewData["image_url"] as! String
        let prodcut_namestr = viewData["product_name"] as! String
        let product_amountstr = viewData["quantity"] as! String
        let product_brandsstr = viewData["brands"] as! String
        self.product_image.moa.url = imageurl
        self.product_name.text = prodcut_namestr
        self.product_brands.text = product_brandsstr
        self.product_amount.text = product_amountstr
          self.keyvalueArray.removeAll()
        let barcode = viewData["id"] as! String
        if let barcode = viewData["id"] as? String {
            self.keyvalueArray.append(barcode)
        }else{
             self.keyvalueArray.append("")
        }
        
        if let packaging = viewData["packaging"] as? String {
            self.keyvalueArray.append(packaging)
        }else{
            self.keyvalueArray.append("")
        }
        if let manufacture = viewData["manufacturing_places"] as? String {
            self.keyvalueArray.append(manufacture)
        }else{
            self.keyvalueArray.append("")
        }
        if let category = viewData["categories"] as? String {
            self.keyvalueArray.append(category)
        }else{
            self.keyvalueArray.append("")
        }
        //t category = viewData["categories"] as! String
      
     
       // let processing_places = viewData[""] as! String
        self.overviewListView.reloadData()
    }
    
    @IBAction func Add_ProductPhoto(_ sender: Any) {
      // elf.SelectPhoto()
    }
  
    
}
extension SearchOverViewVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.keywordArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overviewCell", for: indexPath) as! OverViewCell
        cell.key_name.text = self.keywordArray[indexPath.row]
        cell.key_value.text = self.keyvalueArray[indexPath.row]
        return cell
    }
}
