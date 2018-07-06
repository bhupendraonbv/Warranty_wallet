//
//  CustemServiceCell.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 20/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class CustemServiceCell: UITableViewCell {

    @IBOutlet weak var lblsrvc_Type = UILabel()
    @IBOutlet weak var lblsrvc_Tag = UILabel()
    @IBOutlet weak var lblsrvc_model = UILabel()
    @IBOutlet weak var lblsrvc_DAte = UILabel()
    @IBOutlet weak var lblsrvc_PurchsDate = UILabel()
     @IBOutlet weak var vwBGCell: UIView!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vwBGCell.layer.borderColor = UIColor.clear.cgColor
        vwBGCell.layer.cornerRadius = 5.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
