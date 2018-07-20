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
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
                    if(RecipeBook[recipeBookIndex].DairyList.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Fruits){
                    if(RecipeBook[recipeBookIndex].FruitsList.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Veggie){
                    if(RecipeBook[recipeBookIndex].VeggieList.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.BakedNGrains){
                    if(RecipeBook[recipeBookIndex].BakedNGrainsList.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Seasonings){
                    if(RecipeBook[recipeBookIndex].SeasoningsList.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Legume){
                    if(RecipeBook[recipeBookIndex].LegumeList.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Nut){
                    if(RecipeBook[recipeBookIndex].NutList.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Oils){
                    if(RecipeBook[recipeBookIndex].OilsList.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.Soup){
                    if(RecipeBook[recipeBookIndex].SoupList.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else if(ingrd.Ingrd_Type == FoodType.DairyAlt){
                    if(RecipeBook[recipeBookIndex].DairyAltList.contains(ingrd)){
                        // found the ingredient
                        arr.append(myRecipeIndex)
                    }
                }
                else {
                    if(RecipeBook[recipeBookIndex].BeveragesList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].DairyList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].FruitsList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].VeggieList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].BakedNGrainsList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].SeasoningsList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].MeatList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].SeafoodList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].LegumeList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].NutList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].OilsList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].SoupList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].DairyAltList.contains(ingrd)){
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
                    if(RecipeBook[PRType.index].BeveragesList.contains(ingrd)){
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
                
                // MARK: OMG FIGURE OUT THIS - when deleting, if 0, then move to myRecipe
                
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
