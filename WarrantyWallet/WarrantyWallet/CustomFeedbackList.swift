//
//  CustomFeedbackList.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 23/12/17.
//  Copyright © 2017 ONBV-BHUPI. All rights reserved.
//

import UIKit

class CustomFeedbackList: UITableViewCell {

    @IBOutlet weak var lblTxt = UILabel()
    @IBOutlet weak var lblSubject = UILabel()
    @IBOutlet weak var imgDocument = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
