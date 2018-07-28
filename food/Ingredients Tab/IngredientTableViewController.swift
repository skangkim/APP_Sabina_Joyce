//
//  IngredientTableViewController.swift
//  food
//
//  Created by J Lee on 7/8/18.
//  Copyright © 2018 J Lee. All rights reserved.
//
// var Ingredients = [String]()

import UIKit
import os.log


// global variable
// Limit to the number of ingredients that user need to buy to generate potential recipe
let POT_REP_LIMIT = 2

class IngredientTableViewController: UITableViewController {
    
    //MARK: Properties

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the sample data.
        // loadSampleIngredients()
        
        // Init ingredients
        
        init_IngredBook()
        initRecipeBook()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        setUpNavBar()

    }
    
    func setUpNavBar() {
        let navigationBar = navigationController!.navigationBar
        navigationBar.prefersLargeTitles = true
                navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
        NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 36)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.navigationController?.navigationBar.barTintColor = UIColor("FFAF87")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

//        //get rid of bottom line of navigation
//        let navigationBar = navigationController!.navigationBar
//        navigationBar.isTranslucent = false
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFridge.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "IngredientTableViewCell"
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IngredientTableViewCell  else {
            fatalError("The dequeued cell is not an instance of IngredientTableViewCell.")
        }
        
        //fetches appropriate ingredient for the data source layout
        let ingredient = myFridge[indexPath.row].Name
        // TODO: Find out how to fetch from dictionary
        
        cell.nameLabel.text = ingredient
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            
            // get the ingredient
            let ingrd = myFridge[indexPath.row]
            
            // remove from myFridge
            myFridge.remove(at: indexPath.row)
            
            // store the index of myRecipe which should be removed
            var arr = [Int]()
            
            // update myRecipe
            
            // go through each recipe in Recipe
            for (myRecipeIndex,recipeBookIndex) in myRecipe.enumerated(){
                if(ingrd.Ingrd_Type == FoodType.Dairy){
                    if(RecipeBook[recipeBookIndex].DairyList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Fruits){
                    if(RecipeBook[recipeBookIndex].FruitsList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Veggie){
                    if(RecipeBook[recipeBookIndex].VeggieList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.BakedNGrains){
                    if(RecipeBook[recipeBookIndex].BakedNGrainsList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Seasonings){
                    if(RecipeBook[recipeBookIndex].SeasoningsList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Meat){
                    if(RecipeBook[recipeBookIndex].MeatList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Seafood){
                    if(RecipeBook[recipeBookIndex].SeafoodList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Legume){
                    if(RecipeBook[recipeBookIndex].LegumeList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Nut){
                    if(RecipeBook[recipeBookIndex].NutList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Oils){
                    if(RecipeBook[recipeBookIndex].OilsList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Soup){
                    if(RecipeBook[recipeBookIndex].SoupList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.DairyAlt){
                    if(RecipeBook[recipeBookIndex].DairyAltList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else {
                    if(RecipeBook[recipeBookIndex].BeveragesList.keys.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
            }
            
            // delete from myRecipe
            arr.sort()
            arr.reverse()
            for i in arr{
                myRecipe.remove(at: i)
            }
            
            // update potentialRecipe
            
            // stores index to delete
            var arr1 = [Int]()
            
            for (i,PRType) in potentialRecipe.enumerated(){
                if(ingrd.Ingrd_Type == FoodType.Dairy){
                    if(RecipeBook[PRType.index].DairyList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Fruits){
                    if(RecipeBook[PRType.index].FruitsList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Veggie){
                    if(RecipeBook[PRType.index].VeggieList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.BakedNGrains){
                    if(RecipeBook[PRType.index].BakedNGrainsList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Seasonings){
                    if(RecipeBook[PRType.index].SeasoningsList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Meat){
                    if(RecipeBook[PRType.index].MeatList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Seafood){
                    if(RecipeBook[PRType.index].SeafoodList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Legume){
                    if(RecipeBook[PRType.index].LegumeList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Nut){
                    if(RecipeBook[PRType.index].NutList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Oils){
                    if(RecipeBook[PRType.index].OilsList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Soup){
                    if(RecipeBook[PRType.index].SoupList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.DairyAlt){
                    if(RecipeBook[PRType.index].DairyAltList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                else {
                    if(RecipeBook[PRType.index].BeveragesList.keys.contains(ingrd)){
                        // found the ingredient
                        if(PRType.ingredList.count >= POT_REP_LIMIT){
                            // need to remove from potential Recipe
                            arr1.append(i)
                        }
                        else{
                            // append to the ingredient list to make the potential recipe
                            PRType.ingredList.append(ingrd)
                        }
                    }
                }
                
                
                arr1.sort()
                arr1.reverse()
                for i in arr1{
                    potentialRecipe.remove(at: i)
                }
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    //MARK: Private Methods
    
}

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
