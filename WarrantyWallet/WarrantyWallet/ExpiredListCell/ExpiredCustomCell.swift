//
//  ExpiredCustomCell.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 09/02/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class ExpiredCustomCell: UITableViewCell {

    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var vwBGCell: UIView!
    @IBOutlet weak var ImgBGCell: UIImage!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var purchasedDate: UILabel!
    @IBOutlet weak var btnVW: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var modelProduct: UILabel!
    @IBOutlet weak var btnlogService: UIButton!
    @IBOutlet weak var lblSubCat: UILabel!
    
    @IBOutlet weak var lblAlignWararnty: UILabel!
    
      @IBOutlet weak var vwWarrntyLftSide: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        vwWarrntyLftSide.layer.cornerRadius = 3.0
        
        lblAlignWararnty.text = "WARRANTY"
        lblAlignWararnty.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        vwBGCell.layer.borderColor = UIColor.clear.cgColor
        vwBGCell.layer.cornerRadius = 5.0
        
       // btnDelete.layer.borderColor =  UIColor(red:78/255.0, green:178/255.0, blue:175/255.0, alpha: 1.0).cgColor
       // btnDelete.layer.borderWidth = 2.0
        //btnDelete.layer.cornerRadius = 2.0
        
        
        btnlogService.layer.borderColor =  UIColor(red:78/255.0, green:178/255.0, blue:175/255.0, alpha: 1.0).cgColor
        btnlogService.layer.borderWidth = 2.0
        btnlogService.layer.cornerRadius = 2.0
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
