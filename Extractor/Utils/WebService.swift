//
//  WebService.swift
//  Extractor
//
//  Created by Jin Omori on 12/1/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class WebService {
    public func SearchProdcut(product_name: String, completionHandler:@escaping([String:Any]?)->Void){
        AF.request(AppConstant.productname_Mainurl + product_name + ".json",
                   method: .get, parameters: nil).responseJSON { (response) in
                    switch response.result {
                    case .success(let json):
                        let data = json as! [String:Any]
                        completionHandler(data)
                        break
                    case .failure(let error):
                        completionHandler(nil)
                        break
                    }
        }
    }
    public func SearchBarCode(barcode: String, completionHandler:@escaping([String:Any]?)->Void){
        AF.request(AppConstant.barcode_Mainurl + barcode + ".json",
                   method: .get, parameters: nil).responseJSON { (response) in
                    switch response.result {
                    case .success(let json):
                        let data = json as! [String:Any]
                        completionHandler(data)
                        break
                    case .failure(let error):
                        completionHandler(nil)
                        break
                    }
        }
    }
}
