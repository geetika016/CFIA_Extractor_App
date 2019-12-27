//
//  AddOverViewVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class AddOverViewVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var product_barcodelbl: UILabel!
    
    @IBOutlet weak var product_status: UILabel!
    var pr_barcode: String = ""
    var pr_status: String = ""
    var product_imagedata: UIImage!
    
    @IBOutlet weak var image_height: NSLayoutConstraint!
    
    @IBOutlet weak var scan_lbl: UILabel!
    @IBOutlet weak var scan_resultview: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.LoadData()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.product_barcodelbl.text = self.pr_barcode
        self.product_status.text = self.pr_status
        self.image_height.constant = 0
        self.scan_lbl.isHidden = true
        self.scan_resultview.isHidden = true
        self.product_image.isHidden = true
        
        
    }
    func LoadData(){
        self.product_image.image = product_imagedata
    }
    
    @IBAction func Edit_productInfo(_ sender: Any) {
        
    }
    
    @IBAction func Add_productImage(_ sender: Any) {
        self.SelectPhoto()
    }
    func SelectPhoto(){
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            // self.flag = 0
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You can't use the camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openPhotoLibrary() {
        //self.flag = 1
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            self.product_image.isHidden = false
            self.image_height.constant = 200
            self.product_image.image = image
            let processor = ScaledElementProcessor()
            processor.process(in: self.product_image) { text in
                print(text)
              
                self.scan_lbl.isHidden = false
                self.scan_resultview.isHidden = false
                self.scan_resultview.text = text
                //self.showAlert(text)
            }
            let imageData = image.jpegData(compressionQuality: 0.9)!
            
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}
