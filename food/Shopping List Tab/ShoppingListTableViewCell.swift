//
//  ShoppingListTableViewCell.swift
//  food
//
//  Created by J Lee on 7/18/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    //var item: Item?
//    var onClick: ( (ShoppingListTableViewCell) -> () )?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ring: UIImageView!
    @IBOutlet weak var filledInCircle: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    @IBAction func doneButton(_ sender: UIButton) {
//        onClick?(self)
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
