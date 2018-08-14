//
//  AddToListViewController.swift
//  food
//
//  Created by J Lee on 8/1/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit
import SearchTextField

class AddToListViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var quanitity: UITextField!
    @IBOutlet weak var ingredientName: SearchTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Configure a simple search text field
        configureSimpleSearchTextField()
        // Do any additional setup after loading the view.
        ingredientName.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToListTapped(_ sender: Any) {
        //MARK: TODO: add the ingredient to the shopping list
        //ingredientName is for imput of title of the ingredient
        //quanitity is for imput of quanitity of ingredient
    }
    
    fileprivate func configureSimpleSearchTextField() {
        // Start visible even without user's interaction as soon as created - Default: false
        ingredientName.startVisibleWithoutInteraction = false
        
        //        // Set specific comparision options - Default: .caseInsensitive
        //        nameTextField.comparisonOptions = [.caseInsensitive]
        //
        //        // You can also limit the max height of the results list
        //        nameTextField.maxResultsListHeight = 10
        
        // Set the max number of results. By default it's not limited
        ingredientName.maxNumberOfResults = 5
        
        ingredientName.theme.font = UIFont.systemFont(ofSize: 16)
        
        // Handle item selection - Default behaviour: item title set to the text field
        ingredientName.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            // Do whatever you want with the picked item
            self.ingredientName.text = item.title
            item.subtitle = "this is subtitle for AddtoListView" // TODO: todo
            // item.subtitle = FTtoSTRING(ing_in: IngredBook[self.ingredientName.text!]!)
            self.ingredientName.resignFirstResponder()
            self.ingredientName.hideResultsList()
            self.ingredientName.text = item.title
        }
        
        // Set data source
        
        let ingredDropDown = [String](arrayLiteral: "Dairy", "Fruits", "Veggie", "Baked Goods & Grains", "Seasonings", "Legume", "Meat", "Seafood", "Nut", "Oils", "Soup", "Dairy Alternatives", "Beverages")
        ingredientName.filterStrings(ingredDropDown)
        
}

}
