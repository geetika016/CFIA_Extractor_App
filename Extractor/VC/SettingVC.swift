//
//  SettingVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    
    @IBOutlet weak var description_lbl: UILabel!
    @IBOutlet weak var lang_switch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.title = "Settings"
        self.lang_switch.isOn = false
        description_lbl.text = "Version No: 1.0.0" + "\n" + "Contact Us: abc@hotmail.com"
        lang_switch.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
    }
    @objc func switchValueDidChange()
    {
        if (self.lang_switch.isOn == true){
            print("on")
//            Numéro de version: 1.0.0
//            Contactez nous: abc@hotmail.com
            description_lbl.text = "Numéro de version: 1.0.0" + "\n" + "Contactez nous: abc@hotmail.com"
        }
        else{
            print("off")
            description_lbl.text = "Version No: 1.0.0" + "\n" + "Contact Us: abc@hotmail.com"
        }
    }
    
}
