//
//  ViewController.swift
//  food
//
//  Created by J Lee on 7/24/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit

var FavoritesList = [Int]() // keep track of the index
class SearchViewController: UIViewController {
    
    var index: Int?
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var steps: UILabel!
    
    @IBOutlet weak var filledHeart: UIImageView!
    @IBAction func heartTapped(_ sender: Any) {
        //delete from favorites
        if FavoritesList.contains(index!) {
            let image = UIImage(named: "")
            filledHeart.image = image
            let delete = FavoritesList.index(of: index!) as! Int
            FavoritesList.remove(at: delete)
        }
        else {
            let image = UIImage(named: "icons8-heart-30.png")
            filledHeart.image = image
            FavoritesList.append(index!)
            
        }
        
    }
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var numIngredientsNeeded: UILabel!
    
    // assuming that index (index of RecipeBook) is in potential recipe
    
    @IBAction func addShoppingListTapped(_ sender: UIButton) {
        // MARK: TODO: need to ask questions at the meeting
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationItem.title = RecipeBook[index!].FoodName;
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor("8cd600")
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        //        //get rid of bottom line of navigation
        //        let navigationBar = navigationController!.navigationBar
        //        navigationBar.isTranslucent = false
        //        navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        navigationBar.shadowImage = UIImage()
        
        //setting the page info 
        print(RecipeBook[index!].FoodName)
        recipeName.text = RecipeBook[index!].FoodName
        steps.text = RecipeBook[index!].Steps
        if potentialRecipe[index!].ingredList.count == 0 {
            numIngredientsNeeded.text = ""
            addButton.isHidden = true
        }
        else if potentialRecipe[index!].ingredList.count == 1 {
            numIngredientsNeeded.text = "You need 1 more ingredient!"
        }
        else {
            numIngredientsNeeded.text = "You need " + String(potentialRecipe[index!].ingredList.count) + " more ingredients!"
        }
        if FavoritesList.contains(index!) {
            let image = UIImage(named: "icons8-heart-30.png")
            filledHeart.image = image
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
