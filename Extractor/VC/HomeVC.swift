//
//  HomeVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit
import moa
import BarcodeScanner
class HomeVC: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var scan_BarcodeBtn: UIImageView!
    @IBOutlet weak var search_ProductView: UISearchBar!
    
    @IBOutlet weak var search_resultView: UITableView!
    var resultDatas = NSMutableArray()
    var scanViewcontroller:BarcodeScannerViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        if let saved = UserDefaults.standard.value(forKey: "saved_productDatas") as? [String: Any] {
            AppData.shared.historyData = saved["history_data"] as! NSMutableArray
        }else{
            AppData.shared.historyData = NSMutableArray()
        }
        print(AppData.shared.historyData)
        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.title = "Search"
        let scan_gesture = UITapGestureRecognizer(target: self, action: #selector(Open_Scanner))
        self.scan_BarcodeBtn.isUserInteractionEnabled = true
        self.scan_BarcodeBtn.addGestureRecognizer(scan_gesture)
        self.search_ProductView.delegate = self
        self.search_resultView.dataSource = self
        self.search_resultView.delegate = self
    }
    @objc func Open_Scanner(){
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "scanVC") as! ScanBarcodeVC
//        self.navigationController?.pushViewController(vc, animated: true)
        scanViewcontroller = BarcodeScannerViewController()
        scanViewcontroller.codeDelegate = self
        scanViewcontroller.hidesBottomBarWhenPushed = true
       // viewController.isOneTimeSearch = false
        
        scanViewcontroller.title = "Scan Barcode"
        
        navigationController?.pushViewController(scanViewcontroller, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .groupTableViewBackground
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isHidden = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        let keyword_str = searchBar.text as! String
        self.SearchProduct_Name(keyword: keyword_str)
        search_ProductView.text = ""
        searchBar.resignFirstResponder()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchBar.resignFirstResponder()
    }

}
extension HomeVC{
    func SearchProduct_Name(keyword: String){
        self.resultDatas = NSMutableArray()
        AppData.shared.showLoadingIndicator(view: self.view)
        WebService().SearchProdcut(product_name: keyword){ (response) in
            if let json = response {
                AppData.shared.hideLoadingIndicator()
                do{
                    let resultData = json as! NSDictionary
                    let productDatas = resultData["products"] as! NSArray
                    //self.resultDatas = productDatas
                    if (productDatas.count > 0){
                     //  let eachData = productDatas[0] as! NSDictionary
                        for index1 in 0..<productDatas.count {
                            let eachData = productDatas[index1] as! NSDictionary
                            
                            if let imageurl = eachData["image_url"] as? String {
                                self.resultDatas.add(eachData)
                            }else {
                                //self.resultDatas.remove
                            }
                        }
                    }
                    else{
                        self.showAlert("There is no this product name.")
                    }
                    
                    self.search_resultView.reloadData()
                       //print("*****************************")
                    
                   
                    
                    
                     //  print("*****************************")
                }catch(let error){
                    
                }
            }else{
                 AppData.shared.hideLoadingIndicator()
            }
            
        }
    }
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultDatas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCell
        cell.selectionStyle = .none
        let celldata = self.resultDatas[indexPath.row] as! NSDictionary
        if let imageurl = celldata["image_url"] as? String {
             cell.product_image.moa.url = imageurl
        }else{
             cell.product_image.moa.url = ""
        }
        if let prodcut_name = celldata["product_name"] as? String {
             cell.product_name.text = prodcut_name
        }else{
             cell.product_name.text = ""
        }
        
        if let product_amount = celldata["quantity"] as? String {
              cell.product_amount.text = product_amount
        }else{
              cell.product_amount.text = ""
        }
        if let product_brands = celldata["brands"] as? String {
             cell.product_lbl.text = product_brands
        }else{
             cell.product_lbl.text = ""
        }
        
      
       
       
       
      //  print("*****************************")
        // print(product_brands)
       // print("*****************************")
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "searchresultVC") as! SearchResultVC
        let celldata = self.resultDatas[indexPath.row] as! [String : Any]
        let celldata1 = self.resultDatas[indexPath.row] as! NSDictionary
        vc.productData = celldata1
        //self.SaveData(productData: celldata)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension HomeVC: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        self.ScanProductwithBarcode(barcode: code)
       // controller.reset()
      //  controller.reset()
    }
    func ScanProductwithBarcode(barcode: String){
       AppData.shared.showLoadingIndicator(view: self.view)
        WebService().SearchBarCode(barcode: barcode){ (response) in
            if let json  = response {
                AppData.shared.hideLoadingIndicator()
                do {
                    let resultData = json as! NSDictionary
                    let status = resultData["status"] as! Int
                    if (status == 1){
                        let data = resultData["product"] as! NSDictionary
                        //self.scan_resultView.isHidden = true
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "scanresultVC") as! ScanResultVC
                        vc.productData = data
                        self.presentPanModal(vc)
                        self.scanViewcontroller.reset()
                        
                    }else{
                        
                        self.showAlert("Product not found")
                        self.scanViewcontroller.reset()
                    }
                }catch(let error){
                    AppData.shared.hideLoadingIndicator()
                }
            }else {
                AppData.shared.hideLoadingIndicator()
            }
            
        }
    }
    
}
