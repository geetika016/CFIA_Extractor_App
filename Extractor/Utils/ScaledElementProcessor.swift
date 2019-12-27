//
//  ScaledElementProcessor.swift
//  Extractor
//
//  Created by Jin Omori on 12/1/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import Foundation
import Firebase

class ScaledElementProcessor {
    let vision = Vision.vision()
    var textRecognizer: VisionTextRecognizer!
    init() {
        textRecognizer = vision.onDeviceTextRecognizer()
    }
    func process(in imageView: UIImageView,
                 callback: @escaping (_ text: String) -> Void) {
        // 1
        guard let image = imageView.image else { return }
        // 2
        let visionImage = VisionImage(image: image)
        // 3
        textRecognizer.process(visionImage) { result, error in
            // 4
            guard
                error == nil,
                let result = result,
                !result.text.isEmpty
                else {
                    callback("")
                    return
            }
            // 5
            callback(result.text)
        }
    }
    
}
