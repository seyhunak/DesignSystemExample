//
//  UIViewController+AlertView.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 25.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if options.count == 0 {
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                 completion(0)
            })
            alertController.addAction(OKAction)
        } else {

            for (index, option) in options.enumerated() {
                 alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                    completion(index)
                }))
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
