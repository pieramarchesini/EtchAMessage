//
//  Extensions.swift
//  EtchAMessage MessagesExtension
//
//  Created by Piera Marchesini on 06/02/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}
