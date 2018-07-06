//
//  DashboardCustomCell.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 03/11/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class DashboardCustomCell: UITableViewCell {

    @IBOutlet weak var lblperchDt : UILabel?
    @IBOutlet weak var btnBult : UIButton?
    @IBOutlet weak var lblExpDT : UILabel?
    @IBOutlet weak var lblGroup : UILabel?
    @IBOutlet weak var lblGroupFamily : UILabel?
    @IBOutlet weak var lblProductType : UILabel?
    @IBOutlet weak var lblExepDate : UILabel?
    @IBOutlet weak var btnExpndWrnt : UIButton?
    @IBOutlet weak var lblHdeExpirng : UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
