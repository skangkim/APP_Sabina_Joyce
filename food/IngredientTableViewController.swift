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

var IngredArray = [String]()

func init_IngredArray(){
    IngredArray.append("Banana")
    IngredArray.append("Milk")
    IngredArray.append("Egg")
    IngredArray.append("Bacon")
    IngredArray.append("Chicken")
    IngredArray.append("Salt")
}

class IngredientTableViewController: UITableViewController {
    
    //MARK: Properties

    override func viewDidLoad() {
        super.viewDidLoad()

        //Load the sample data.
        // loadSampleIngredients()
        
        // Init ingredients
        
        init_IngredBook()
        init_IngredArray()
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
        return IngredArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "IngredientTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IngredientTableViewCell  else {
            fatalError("The dequeued cell is not an instance of IngredientTableViewCell.")
        }
        
        //fetches appropriate ingredient for the data source layout
        let ingredient = IngredArray[indexPath.row]
        // TODO: Find out how to fetch from dictionary
        
        cell.nameLabel.text = ingredient

        return cell
    }
    

    // Override to support conditional editing of the table view.


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            IngredArray.remove(at: indexPath.row) // TODO: What is this
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
    
    //tester function
    private func loadSampleIngredients() {

        
        // Ingredients += ["apples", "banana", "oranges"]
    }
}
