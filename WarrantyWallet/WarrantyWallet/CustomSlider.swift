//
//  CustomSlider.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 26/04/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 5.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }


}
