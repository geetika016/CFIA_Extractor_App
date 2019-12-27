//
//  ScanBarcodeVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit
import MTBBarcodeScanner
import BarcodeScanner
class ScanBarcodeVC: UIViewController {

    @IBOutlet weak var previewView: UIView!
   // var scanner: MTBBarcodeScanner?
    
    @IBOutlet weak var scan_resultView: UIView!
    @IBOutlet weak var scan_imageView: UIImageView!
    @IBOutlet weak var result_Lbl: UILabel!
    @IBOutlet weak var result_namelbl: UILabel!
    @IBOutlet weak var result_amountlbl: UILabel!
    var productData = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        // Do any additional setup after  the view.
    }
    func initUI(){
        //self.scanner = MTBBarcodeScanner(previewView: self.previewView)
        //self.scanner.
        let title_view = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        title_view.textColor = .white
        title_view.text = "Scan the barcode"
        title_view.font = UIFont.boldSystemFont(ofSize: 20)
        title_view.textAlignment = .center
        navigationItem.titleView = title_view
        let navBarColor = UIColor.init(red: 48/255, green: 48/255, blue: 54/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = navBarColor
        self.navigationController?.navigationBar.isTranslucent = false
        let result_gesture = UITapGestureRecognizer(target: self, action: #selector(Open_ProductVC))
        self.scan_resultView.addGestureRecognizer(result_gesture)
        
//        let dismiss_gesture = UITapGestureRecognizer(target: self, action: #selector(DismissView))
//        self.previewView.addGestureRecognizer(dismiss_gesture)
        
        
       // self.view.addSubview(viewController.view)
        

    }
    @objc func DismissView(){
        self.scan_resultView.isHidden = true
        self.viewWillAppear(true)
    }
    @objc func Open_ProductVC(){
        self.scan_resultView.isHidden = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "scanresultVC") as! ScanResultVC
        vc.productData = self.productData
        presentPanModal(vc)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scan_resultView.isHidden = true
//        self.previewView.isHidden = false
//        self.tabBarController?.selectedIndex = 0
//        MTBBarcodeScanner.requestCameraPermission(success: { success in
//            if success {
//                do {
//                    try self.scanner?.startScanning(resultBlock: { codes in
//                        if let codes = codes {
//                            let count = codes.count as! Int
//                            var i : Int = 0
//                            for code in codes {
//                                let stringValue = code.stringValue as! String
//                                print("Found code: \(stringValue)")
//                                i = i + 1
//                                if ( i == count) {
//                                  self.scanner?.stopScanning()
//                                  //self.scan_resultView.isHidden = false
//                                  self.ScanProductwithBarcode(barcode: stringValue)
//
//                                }
//                            }
//                        }
//                    })
//                } catch {
//                    //NSLog("Unable to start scanning")
//                    let alertController = UIAlertController(title: "Scanning Unavailable", message: "Unable to start scanning", preferredStyle: UIAlertController.Style.alert)
//                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
//                    self.present(alertController, animated: true, completion: nil)
//
//                }
//            } else {
//                let alertController = UIAlertController(title: "Scanning Unavailable", message: "This app does not have permission to access the camera", preferredStyle: UIAlertController.Style.alert)
//                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
//                self.present(alertController, animated: true, completion: nil)
////                  self.ScanProductwithBarcode(barcode: "0096619525973")
//            }
//        })
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
                        self.productData = data
                        self.LoadData(viewData: data)
                        
                    }else{
                        self.showAlert("Product not found")
                    }
                }catch(let error){
                    AppData.shared.hideLoadingIndicator()
                }
            }else {
                AppData.shared.hideLoadingIndicator()
            }
            
        }
    }
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    func LoadData(viewData: NSDictionary){
        self.scan_resultView.isHidden = false
        let imageurl = viewData["image_url"] as! String
        let prodcut_namestr = viewData["product_name"] as! String
        let product_amountstr = viewData["quantity"] as! String
        let product_brandsstr = viewData["brands"] as! String
        self.scan_imageView.moa.url = imageurl
        self.result_Lbl.text = prodcut_namestr
        self.result_namelbl.text = product_brandsstr
        self.result_amountlbl.text = product_amountstr
    }
    
}
