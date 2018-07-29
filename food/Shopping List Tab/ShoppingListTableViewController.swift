//
//  ShoppingListTableViewController.swift
//  food
//
//  Created by J Lee on 7/18/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit

var shoppingListArray = [(Int, NSOrderedSet)]() // index of recipebook

class ShoppingListTableViewController: UITableViewController {
    
    var addedIngredient: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let navigationBar = navigationController!.navigationBar
        navigationBar.prefersLargeTitles = true
                navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.navigationController?.navigationBar.barTintColor = UIColor("FFAF87")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
//        //get rid of bottom line of navigation
//        let navigationBar = navigationController?.navigationBar
//        navigationBar?.isTranslucent = false
//        navigationBar?.setBackgroundImage(UIImage(), for: .default)
//        navigationBar?.shadowImage = UIImage()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    var index: Int?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return shoppingListArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
        //TODO: how to make dynamic tableView
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int, indexPath: IndexPath) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
        view.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 30))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        //label.text = RecipeBook[shoppingListArray[indexPath.row].0].FoodName
        view.addSubview(label)
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as? ShoppingListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of IngredientTableViewCell.")
        }
        
        //fetches appropriate recipie for the data source layout
        cell.recipeName.text = RecipeBook[shoppingListArray[indexPath.row].0].FoodName
        // MARK: TODO: how to get the ingredients needed for the recipe
        //cell.nameLabel.text = shoppingListArray[indexPath.row].1.object(at: indexPath.section) as (Ingrd, foodMeasureUnit).0.Name
        
        let image = UIImage(named: "shoppinglistbutton.jpg")
        cell.ring.image = image


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as? ShoppingListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of IngredientTableViewCell.")
        }
        
            let image = UIImage(named: "filledIn.jpg")
            cell.filledInCircle.image = image
        
                performSegue(withIdentifier: "addToFridge", sender: addedIngredient)
            
            //MARK: TODO: add the checked item to fridge as an Ingrd(?) type (currently just passed as a String)
            addedIngredient = cell.nameLabel.text
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                // Your code with delay
                //                shoppingListArray.remove(at: indexPath.row)
                //                tableView.deleteRows(at: [indexPath], with: .fade)
                //switch status
                
                tableView.reloadData()
            }
            
            deleteRecipes()
            //switch status
            tableView.reloadData()
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            shoppingListArray.remove(at: indexPath.row)
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
    
    func deleteRecipes() {
        //MARK: TODO: function that deletes the recipe from the ShoppingListArray
        //if all the ingredients are checked off (how to check this?)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        super.prepare(for: segue, sender: sender)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let data = addedIngredient
        
        if let destinationViewController = segue.destination as? popupViewController {
            destinationViewController.addedIngredient = data
        }
        
    }
}

