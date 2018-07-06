//
//  CustomCellVerificationTableViewCell.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 30/04/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class CustomCellVerificationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblCatList: UILabel!
    @IBOutlet weak var lblSubCat: UILabel!
    @IBOutlet weak var lblDateExp: UILabel!
    @IBOutlet weak var vwBgCurve: UIView!
    
    @IBOutlet weak var lblTopHdr: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vwBgCurve.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
