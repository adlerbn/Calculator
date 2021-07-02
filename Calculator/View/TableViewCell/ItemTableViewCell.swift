//
//  ItemTableViewCell.swift
//  Calculator
//
//  Created by Yahya Bn on 7/1/21.
//  Copyright © 2021 Yahya Bn. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    static let identifier: String = "ItemTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ItemTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
