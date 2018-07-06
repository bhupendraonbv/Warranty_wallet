//
//  CustmRequestCell.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 09/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class CustmRequestCell: UITableViewCell {

    //Declare property Here.
    @IBOutlet weak var ImgProces: UIImageView!
    @IBOutlet weak var lblReqstWrnty: UILabel!
    @IBOutlet weak var lblPrdctReqst: UILabel!
    @IBOutlet weak var lblprdctDate: UILabel!
    @IBOutlet weak var lblprdctdetails: UILabel!
    @IBOutlet weak var lblstsPrcsng: UILabel!
    @IBOutlet weak var lblstsPrcd: UILabel!
    @IBOutlet weak var imgBgCell: UIImageView!
    @IBOutlet weak var vwBGCell: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgBgCell.layer.borderColor = UIColor.clear.cgColor
        imgBgCell.layer.cornerRadius = 5.0
        
        vwBGCell.layer.borderColor = UIColor.clear.cgColor
        vwBGCell.layer.cornerRadius = 5.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
