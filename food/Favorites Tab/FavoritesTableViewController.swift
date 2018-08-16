//
//  FavoritesTableViewController.swift
//  food
//
//  Created by J Lee on 7/23/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit
import CoreData

var FavList = [NSManagedObject]()

func fetch_FavList(){
    FavList = []
    let context = AppDelegate.viewContext
    let request = NSFetchRequest<Recipe>(entityName: "Recipe")
    request.predicate = NSPredicate(format: "isFav == %@", NSNumber(value: true))
    do{
        FavList = try context.fetch(request) as [NSManagedObject]
    }
    catch let error as NSError{
        print("couldnt get fav list \(error)")
    }
}

class FavoritesTableViewController: UITableViewController {
    var index: Recipe?
    
    @IBOutlet weak var zeroLabel: UILabel!
//    @IBAction func favoritesTapped(_ sender: Any) {
//        if FavoritesList.contains(index) {
//            let image = UIImage(named: "")
//            heartFilled.image = image
//            let delete = FavoritesList.index(of: index) as! Int
//            FavoritesList.remove(at: delete)
//        }
//        else {
//            let image = UIImage(named: "icons8-heart-30.png")
//            heartFilled.image = image
//            FavoritesList.append(index)
//
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch_FavList()
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 150
        tableView.estimatedRowHeight = 150
        
        let navigationBar = navigationController!.navigationBar
        navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch_FavList()
        tableView.reloadData()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        if FavList.count == 0 {
            TableViewHelper.EmptyMessage(message: "Your Favorite Recipies go here! \n Click the heart on the recipes that you love", viewController: self)
        } else {
            TableViewHelper.EmptyMessage(message: "", viewController: self)
//            tableView.backgroundColor = UIColor.lightGray
        }
        
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        tableView.reloadData()
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
        return FavList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as? FavoritesTableViewCell  else {
            fatalError("The dequeued cell is not an instance of IngredientTableViewCell.")
        }
        cell.recipeTitle.text! = FavList[indexPath.row].value(forKey: "name") as! String
        let image = UIImage(named: "icons8-heart-30.png")
        cell.filledHeart.image = image
        //when favorites heart clicked
        cell.onClick = { cell in
            
            let context = AppDelegate.persistentContainer.viewContext
            
            // heart button function
            // set isFav to false
            
            let this_recipe = FavList[indexPath.row] as! Recipe
            if(this_recipe.isFav){
                let image = UIImage(named: "icons8-heart-30.png")
                cell.filledHeart.image = image
                this_recipe.setValue(false, forKey: "isFav")
                FavList.remove(at: indexPath.row)
                tableView.reloadData()
                
                if FavList.count == 0 {
                    TableViewHelper.EmptyMessage(message: "Your Favorite Recipies go here! \n Click the heart on the recipes that you love", viewController: self)
                } else {
                    TableViewHelper.EmptyMessage(message: "", viewController: self)
                }
                
            }
            else{
                let image = UIImage(named: "")
                cell.filledHeart.image = image
                print("ERROR in heart button - it should always be true. Not modifying isFav for debugging")
            }
            
            
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            // save changes
            do{ try context.save() }
            catch let error as NSError{ print("couldnt set isFav @ tableview at FavTVC. Error: \(error)") }
        }
        
        //set shadow
        cell.cellView.layer.shadowColor = UIColor.gray.cgColor
        cell.cellView.layer.shadowOpacity = 1
        cell.cellView.layer.shadowOffset = CGSize.zero
        cell.cellView.layer.shadowRadius = 8
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = FavList[indexPath.row] as! Recipe
        performSegue(withIdentifier: "favoritesFullRecipe", sender: index)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        super.prepare(for: segue, sender: sender)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let data = index
        
        if let destinationViewController = segue.destination as? SearchViewController {
            destinationViewController.index = data
        }
        
    }
    
}
class TableViewHelper {
    
    class func EmptyMessage(message:String, viewController:UITableViewController) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: viewController.view.bounds.size.width, height: viewController.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.darkGray
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        messageLabel.sizeToFit()
        
        viewController.tableView.backgroundView = messageLabel
        
    }
}
