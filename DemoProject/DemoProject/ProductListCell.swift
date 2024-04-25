//
//  ProductListCell.swift
//  DemoProject
//
//  Created by BeLocum-6 on 23/04/24.
//  Copyright © 2024 Belocum. All rights reserved.
//

import UIKit

class ProductListCell: UITableViewCell {
    
    @IBOutlet weak var lbltxtProductName:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configuare(productModel:Products) {
        lbltxtProductName.text = productModel.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
