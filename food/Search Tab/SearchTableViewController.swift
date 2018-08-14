//
//  SearchTableViewController.swift
//  food
//
//  Created by J Lee on 7/23/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit
import CoreData

var PotRecipeArr = [PotRecipe]() // TODO: potRecipe datastructure
var MyRecipeArr = [Recipe]() // TODO: MyRecipeArr

func update_my_and_pot_Recipe(){
    // remove everything
    MyRecipeArr = []
    PotRecipeArr = []
    
    // get Set of ingredients in fridge
    var ingredInfoarr = [IngredInfo]()
    for i in fridge{
        ingredInfoarr.append(i.ingredInfo!)
    }
    let fridgeSet = Set(fridge)
    
    
    
    AppDelegate.persistentContainer.performBackgroundTask{ context in
        do{
            // get all recipe
            let fetchRecipe = NSFetchRequest<Recipe>(entityName: "Recipe")
            fetchRecipe.predicate = NSPredicate(format: "ALL")
            let fridgeIngredInfoSet = Set(ingredInfoarr)
            let recipes = try context.fetch(fetchRecipe)
            
            for recipe in recipes{
                if(recipe.ingredients.isSubset(of: fridgeIngredInfoSet)){
                    MyRecipeArr.append(recipe)
                }
                else{
                    // check for potential recipes
                    let arr = recipe.ingredients.allObjects as? [Ingred]
                    var count = 0
                    var arr_need_ingred = [Ingred]()
                    for ingred in arr! {
                        if count > 3 { break }
                        if !fridgeSet.contains(ingred) {
                            count += 1
                            arr_need_ingred.append(ingred)
                        }
                    }
                    if count <= 2{
                        // found 
                        let e_recipe = NSEntityDescription.entity(forEntityName: "PotRecipe", in: context)
                        let new_pot_recipe = PotRecipe(entity: e_recipe!, insertInto: context)
                        new_pot_recipe.recipe = recipe
                        new_pot_recipe.addToNeed_Ingred(NSSet(array: arr_need_ingred))
                    }
                }
                
            }
        }
        catch let error as NSError{
            print("error in update myRecipe")
            print(error)
        }
        catch{
            print("in update: \(error)")
        }
        // don't forget to save
        do{ try context.save() }
        catch{ print(error) }
    }
}

class SearchTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var index: Int?
    
    @IBOutlet weak var zeroLabel: UILabel!
    
    func didScroll(to position: CGFloat) {
        for cell in tableView.visibleCells as! [SearchTableViewCell] {
            (cell.collectionView as UIScrollView).contentOffset.x = position
        }
    }
    
    // myRecipe
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return MyRecipeArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            print(collectionView.tag)
            print("0", indexPath.section, indexPath.row)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell",
                                                          for: indexPath) as? SearchCollectionViewCell
            
            cell?.recipeName.text = MyRecipeArr[indexPath.row].name
            // cell?.recipeName.text = RecipeBook[potentialRecipe[indexPath.row].index].FoodName
            cell?.moreIngredients.text = "You need \(MyRecipeArr[indexPath.row].ingredients.count) more ingredients!"
            /*
            if MyRecipeArr[indexPath.row].ingredList.count == 0 {
                cell?.moreIngredients.text = "You have all the ingredients to make this!"
            }
            else {
                cell?.moreIngredients.text = "You need " + String(MyRecipeArr[indexPath.row].ingredList.count) + " more ingredients!"
            }*/
            
            //cell?.StepsLabel.text = RecipeBook[indexPath.row].Steps
            setShadow(UICollectionViewCell: cell!)
            
            // show red heart if favorites
            if(MyRecipeArr[indexPath.row].isFav){
                let image = UIImage(named: "icons8-heart-30.png")
                cell?.filledHeart.image = image
            }
            
            //on checkbox click
            cell?.onClick = { cell in
                if(MyRecipeArr[indexPath.row].isFav){
                    // remove from fav list
                    let image = UIImage(named: "")
                    cell.filledHeart.image = image
                    MyRecipeArr[indexPath.row].isFav = false
                }
                else{
                    // add to fav list
                    let image = UIImage(named: "icons8-heart-30.png")
                    cell.filledHeart.image = image
                    MyRecipeArr[indexPath.row].isFav = true
                }
            }
            
            return cell!
            
        }
        else {
            print(collectionView.tag)
            print("1", indexPath.section, indexPath.row)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search2CollectionViewCell",
                                                          for: indexPath) as? Search2CollectionViewCell
            
            cell?.recipeName.text = MyRecipeArr[indexPath.row].name
            // cell?.recipeName.text = RecipeBook[potentialRecipe[indexPath.row].index].FoodName
            cell?.moreIngredients.text = "You need \(MyRecipeArr[indexPath.row].ingredients.count) more ingredients!"
            
            //cell?.StepsLabel.text = RecipeBook[indexPath.row].Steps
            setShadow2(UICollectionViewCell: cell!)
            
            // show red heart if favorites
            if(MyRecipeArr[indexPath.row].isFav){
                let image = UIImage(named: "icons8-heart-30.png")
                cell?.filledHeart.image = image
            }

            //on checkbox click
            cell?.onClick = { cell in
                if(MyRecipeArr[indexPath.row].isFav){
                    // remove from fav list
                    let image = UIImage(named: "")
                    cell.filledHeart.image = image
                    MyRecipeArr[indexPath.row].isFav = false
                }
                else{
                    // add to fav list
                    let image = UIImage(named: "icons8-heart-30.png")
                    cell.filledHeart.image = image
                    MyRecipeArr[indexPath.row].isFav = true
                }
            }
            
            return cell!
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = MyRecipeArr[indexPath.row]
        index = RecipeBook.index(of: recipe)
        performSegue(withIdentifier: "showDaFullRecipe", sender: index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update potRecipe and myRecipe
        // update_my_and_pot_Recipe()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //        setCardView(view: uiView)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        let navigationBar = navigationController!.navigationBar
        navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor("#f7f7f7")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor("FFAF87")
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        if MyRecipeArr.count == 0 {
            TableViewHelper.EmptyMessage(message: "Add Ingredients to see recommended Recipes !!", viewController: self)
        }
        else {
            TableViewHelper.EmptyMessage(message: "Add Ingredients to see recommended Recipes !!", viewController: self)
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(tableView: UITableView,
                   willDisplayCell cell: UITableViewCell,
                   forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            guard let tableViewCell = cell as? SearchTableViewCell else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
        }
        else {
            guard let tableViewCell = cell as? Search2TableViewCell else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeued using a cell identifier.
        
        if indexPath.section == 0 {
            let cellIdentifier = "SearchTableViewCell"
            
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchTableViewCell  else {
                fatalError("The dequeued cell is not an instance of SearchTableViewCell.")
            }
            guard let tableViewCell = cell as? SearchTableViewCell else { return cell }
            
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            tableView.rowHeight = 397.5
            tableView.estimatedRowHeight = 397.5
            
            cell.collectionView.tag = 0
            return cell
        }
        else {
            let cellIdentifier = "Search2TableViewCell"
            
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Search2TableViewCell  else {
                fatalError("The dequeued cell is not an instance of Search2TableViewCell.")
            }
            guard let tableViewCell = cell as? Search2TableViewCell else { return cell }
            
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            tableView.rowHeight = 291.5
            tableView.estimatedRowHeight = 291.5
            
            cell.collection2View.tag = 1
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = MyRecipeArr[indexPath.row]
        index = RecipeBook.index(of: recipe)
        performSegue(withIdentifier: "showDaFullRecipe", sender: index)
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
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tableView.reloadData()
    }
    
}

