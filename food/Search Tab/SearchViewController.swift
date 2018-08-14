//
//  ViewController.swift
//  food
//
//  Created by J Lee on 7/24/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    var index: Int? // mark: assuming this as index at recipebook
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var steps: UILabel!
    
    @IBOutlet weak var filledHeart: UIImageView!
    @IBAction func heartTapped(_ sender: Any) {
        //delete from favorites
        
        if(RecipeBook[index!].isFav){
            // if it's favorite, delete from fav
            let image = UIImage(named: "")
            filledHeart.image = image
            RecipeBook[index!].isFav = false
        }
        else{
            let image = UIImage(named: "icons8-heart-30.png")
            filledHeart.image = image
            RecipeBook[index!].isFav = true
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
        // print(RecipeBook[index!].FoodName)
        // recipeName.text = RecipeBook[index!].FoodName
        
        let recipe = RecipeBook[index!]
        
        recipeName.text = recipe.name
        steps.text = recipe.steps
        
        
        if(recipe.potRecipe != nil){
            let pot_recipe = recipe.potRecipe
            let count = pot_recipe?.need_Ingred?.count
            if count == 0{
                numIngredientsNeeded.text = ""
                addButton.isHidden = true
            }
            else {
                numIngredientsNeeded.text = "You need \(String(describing: count)) more ingredient!"
            }
        }
        else{
            numIngredientsNeeded.text = ""
            addButton.isHidden = true
            
        }
        if(recipe.isFav){
            let image = UIImage(named: "icons8-heart-30.png")
            filledHeart.image = image
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
