//
//  RegistrdInvoiceCell.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 02/12/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class RegistrdInvoiceCell: UITableViewCell {

    @IBOutlet weak var lblTagName = UILabel()
    @IBOutlet weak var lblExpDate = UILabel()
    @IBOutlet weak var lblManuFctr = UILabel()
    @IBOutlet weak var lblModel = UILabel()
    @IBOutlet weak var imgLogoBrand = UIImageView()
    @IBOutlet weak var lblsrvc_model = UILabel()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
