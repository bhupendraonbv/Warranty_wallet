//
//  CustemDocumentCell.swift
//  WarrantyWallet
//
//  Created by ONBV-BHUPI on 16/01/18.
//  Copyright © 2018 ONBV-BHUPI. All rights reserved.
//

import UIKit

class CustemDocumentCell: UITableViewCell {

    @IBOutlet var LblDocumentName: UILabel!
    @IBOutlet var LblDocumentFormat: UILabel!
    @IBOutlet var  imgDocument: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
