//
//  Extensions.swift
//  NewsApp
//
//  Created by Admin on 9/11/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation
import AlamofireImage


extension UIImageView {
    func setImage(fromURL url: URL, animatedOnce: Bool = true, withPlaceholder placeholderImage: UIImage? = #imageLiteral(resourceName: "placeHolder")) {
        let hasImage: Bool = (self.image != nil)
        self.af_setImage(
            withURL: url,
            placeholderImage: placeholderImage,
            imageTransition: animatedOnce ? .crossDissolve(0.3) : .noTransition,
            runImageTransitionIfCached: hasImage
        )
    }
}

extension UINavigationController {
    
    func backToViewController(vc: Any) {
        // iterate to find the type of vc
        for element in viewControllers as Array {
            if "\(type(of: element)).Type" == "\(type(of: vc))" {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}
