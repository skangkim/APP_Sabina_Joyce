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
import CoreData


var fridge = [Ingred]()
// global variable
// Limit to the number of ingredients that user need to buy to generate potential recipe
let POT_REP_LIMIT = 2

class IngredientTableViewController: UITableViewController {
    
    //MARK: Properties

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the sample data.
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        setUpNavBar()
    }
    
    func setUpNavBar() {
        let navigationBar = navigationController!.navigationBar
        navigationBar.prefersLargeTitles = true
                navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
        NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 36)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor("8CD600")
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor("8CD600")]

//        //get rid of bottom line of navigation
//        let navigationBar = navigationController!.navigationBar
//        navigationBar.isTranslucent = false
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
        
        if fridge.count == 0 {
            TableViewHelper.EmptyMessage(message: "Your fridge is empty!", viewController: self)
        }
        else {
            TableViewHelper.EmptyMessage(message: "", viewController: self)
        }
        
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
        return fridge.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "IngredientTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IngredientTableViewCell  else {
            fatalError("The dequeued cell is not an instance of IngredientTableViewCell.")
        }
        //fetches appropriate ingredient for the data source layout
        // fetch ingredients from fridge
        
        AppDelegate.persistentContainer.performBackgroundTask{ context in
            do{
                let fetchFridge = NSFetchRequest<Ingred>(entityName: "Ingred")
                fetchFridge.predicate = NSPredicate(format: "inFridge == %@", NSNumber(value: true))
                do{
                    fridge = try context.fetch(fetchFridge)
                }
                cell.nameLabel.text = fridge[indexPath.row].name
            }
            catch let error as NSError{
                print(error)
            }
        }
        // let ingredient = myFridge[indexPath.row].Name
        // TODO: Find out how to fetch from dictionary
        // cell.nameLabel.text = ingredient
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // MARK: Delete ingredient
        if editingStyle == .delete {
            // Delete the row from the data source
            AppDelegate.persistentContainer.performBackgroundTask{ context in
                do{
                    let del = fridge[indexPath.row]
                    del.inFridge = false
                }
                // don't forget to save
                do{ try context.save() }
                catch{ print(error) }
            }
            
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
