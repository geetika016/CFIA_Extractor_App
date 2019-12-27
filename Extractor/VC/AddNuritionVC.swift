//
//  AddNuritionVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class AddNuritionVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var product_ImageView: UIImageView!
    @IBOutlet weak var product_InfoListView: UITableView!
    var sampleDataTypes: [String] = []
    var sampleDataDetails: [String] = []
    
    @IBOutlet weak var image_height: NSLayoutConstraint!
    
    @IBOutlet weak var scan_lbl: UILabel!
    
    @IBOutlet weak var scan_resultview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.image_height.constant = 0
        self.product_InfoListView.dataSource = self
        self.product_InfoListView.delegate = self
        self.scan_lbl.isHidden = true
        self.scan_resultview.isHidden = true
        self.product_ImageView.isHidden = true    }
    
    @IBAction func Add_ProductPhoto(_ sender: Any) {
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
             self.image_height.constant = 200
            self.product_ImageView.image = image
           
            self.product_ImageView.isHidden = false
            let processor = ScaledElementProcessor()
            processor.process(in: self.product_ImageView) { text in
                print(text)
                self.scan_lbl.isHidden = false
                self.scan_resultview.isHidden = false
                self.scan_resultview.text = text
               // self.showAlert(text)
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
extension AddNuritionVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sampleDataTypes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addnuritionCell", for: indexPath) as! AddNuritionCell
        
        cell.datatype_Lbl.text = self.sampleDataTypes[indexPath.row]
        cell.datadetails_Lbl.text = self.sampleDataDetails[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}
