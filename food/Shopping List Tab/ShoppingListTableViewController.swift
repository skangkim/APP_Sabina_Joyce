//
//  ShoppingListTableViewController.swift
//  food
//
//  Created by J Lee on 7/18/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit

var shoppingListArray = [String]()

func init_shoppingListArray(){
    shoppingListArray.append("3 Bananas")
    shoppingListArray.append("2 cartons Milk")
    shoppingListArray.append("8 Eggs")
    shoppingListArray.append("3 v")
    shoppingListArray.append("2 a")
    shoppingListArray.append("8 s")
    shoppingListArray.append("3 d")
    shoppingListArray.append("2 f Milk")
    shoppingListArray.append("8 g")
    
}

class ShoppingListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        init_shoppingListArray()
        
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingListArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as? ShoppingListTableViewCell  else {
            fatalError("The dequeued cell is not an instance of IngredientTableViewCell.")
        }
        
        //fetches appropriate recipie for the data source layout
        let recipie = shoppingListArray[indexPath.row]
        // TODO: Find out how to fetch from dictionary
        
        let image = UIImage(named: "shoppinglistbutton.jpg")
        cell.ring.image = image
        
        cell.nameLabel.text = recipie
        
        //on checkbox click
        cell.onClick = { cell in
            
            let image = UIImage(named: "filledIn.jpg")
            cell.filledInCircle.image = image
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
                // Your code with delay
                shoppingListArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                //switch status
                tableView.reloadData()
            }
            
            
            //switch status
            tableView.reloadData()
        }
        return cell
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
