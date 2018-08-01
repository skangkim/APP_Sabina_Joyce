//
//  FavoritesTableViewCell.swift
//  food
//
//  Created by J Lee on 7/23/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet var recipeTitle: UILabel!
    var onClick: ( (FavoritesTableViewCell) -> () )?
    @IBOutlet weak var filledHeart: UIImageView!
    @IBAction func favoritesHeartTapped(_ sender: Any) {
        onClick?(self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
