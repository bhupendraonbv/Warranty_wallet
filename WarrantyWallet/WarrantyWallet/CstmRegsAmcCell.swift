//
//  CstmRegsAmcCell.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 08/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class CstmRegsAmcCell: UITableViewCell {

    @IBOutlet weak var icnImg: UIImageView!
    
    @IBOutlet weak var lblRegisAMC: UILabel!
    @IBOutlet weak var lblPrdctName: UILabel!
    @IBOutlet weak var lblSerial: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var vwBGCell: UIView!
    @IBOutlet weak var lblExpiryDate: UILabel!
     @IBOutlet weak var btnDelete: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwBGCell.layer.borderColor = UIColor.clear.cgColor
        vwBGCell.layer.cornerRadius = 10.0
        
        btnDelete.layer.borderColor =  UIColor(red:78/255.0, green:178/255.0, blue:175/255.0, alpha: 1.0).cgColor
        btnDelete.layer.borderWidth = 2.0
        btnDelete.layer.cornerRadius = 2.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
