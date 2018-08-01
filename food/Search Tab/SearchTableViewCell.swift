//
//  SearchTableViewCell.swift
//  food
//
//  Created by J Lee on 7/23/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet  weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setCollectionViewDataSourceDelegate
        <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
        
    }
}

class SearchCollectionViewCell: UICollectionViewCell {
    
var onClick: ( (SearchCollectionViewCell) -> () )?
    
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var filledHeart: UIImageView!
    @IBAction func favoritesHeartTapped(_ sender: Any) {
        onClick?(self)
    }
    
    @IBOutlet weak var moreIngredients: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
}


func setShadow(UICollectionViewCell: SearchCollectionViewCell) {
    UICollectionViewCell.layer.masksToBounds = false
    UICollectionViewCell.layer.shadowOffset = CGSize(width: 0, height: 0)
    UICollectionViewCell.layer.shadowRadius = 2
    UICollectionViewCell.layer.shadowColor = UIColor("FFAF87")?.cgColor
    UICollectionViewCell.layer.shadowOpacity = 0.5
    UICollectionViewCell.layer.cornerRadius = 10
}

