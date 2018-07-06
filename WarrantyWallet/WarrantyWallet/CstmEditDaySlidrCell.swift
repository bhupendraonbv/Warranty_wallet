//
//  CstmEditDaySlidrCell.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 05/01/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class CstmEditDaySlidrCell: UITableViewCell {

    @IBOutlet var LblDays: UILabel!
    @IBOutlet var LblProductNm: UILabel!
    @IBOutlet var sliderTnt: UISlider!
    
    @IBOutlet var vwBGCell: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vwBGCell.layer.cornerRadius = 10.0
        
    }
    
    
    
    
    
    

    class MySlide: UISlider {
        
        @IBInspectable var height: CGFloat = 2
        override func trackRect(forBounds bounds: CGRect) -> CGRect {
            return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: height))
        }
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
