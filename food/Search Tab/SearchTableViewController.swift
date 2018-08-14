//
//  SearchTableViewController.swift
//  food
//
//  Created by J Lee on 7/23/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit
import CoreData

var PotRecipeArr = [NSManagedObject]()
var MyRecipeArr = [NSManagedObject]()


func generate_my_and_pot_Recipe(){
    // remove everything
    MyRecipeArr = []
    PotRecipeArr = []
    
    let context = AppDelegate.persistentContainer.viewContext
    let e_potRecipe = NSEntityDescription.entity(forEntityName: "PotRecipe", in: context)
    do{
        // get all recipe
        let fetchRecipe = NSFetchRequest<Recipe>(entityName: "Recipe")
        let recipes = try context.fetch(fetchRecipe)
        
        // TODO: print contains[c] when? aka variation of milk
        for r in recipes{
            var count = 0;
            let all_ingred = r.ingredients.allObjects as? [IngredInfo] // get all the ingredients that this recipe needs
            print(all_ingred?.count)
            let fetchIngred = NSFetchRequest<Ingred>(entityName: "Ingred") // fetch in Ingred
            let inFridgePred = NSPredicate(format: "inFridge == %@" , NSNumber(value: true)) // those in fridge
            var need_ingred = [Ingred]()
            for i in all_ingred!{
                print(i.ingredients.name)
                let hasInfoPred = NSPredicate(format: "ingredInfo == %@", i) // AND the ones that match this recipe
                fetchIngred.predicate = NSCompoundPredicate(type: .and, subpredicates: [inFridgePred, hasInfoPred])
                let result = try context.fetch(fetchIngred)
                assert(result.count <= 1, "asserting that there's only one or none")
                if(result.count == 0){
                    // this ingredient does not exists - for PotRecipe
                    count += 1
                    need_ingred.append(i.ingredients)
                }
                if(count > 2) { break; }
            }
            if count == 0 {
                MyRecipeArr.append(r)
            }
            else if count <= 2{
                // make new pot recipe
                let pot = PotRecipe(entity: e_potRecipe!, insertInto: context)
                pot.setValue(NSSet(array: need_ingred), forKey: "need_Ingred")
                pot.setValue(r, forKey: "recipe")
                // append to PotRecipe Arr
                PotRecipeArr.append(pot)
            }
        }
        
    }
    catch let error as NSError{
        print("update my_and_pot_recipe ERROR: \(error)")
    }
    
    do{ try context.save() }
    catch { print("failed saving my_and_pot_recipe") }
}




class SearchTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var index: Int?
    
    @IBOutlet weak var zeroLabel: UILabel!
    
    func didScroll(to position: CGFloat) {
        for cell in tableView.visibleCells as! [SearchTableViewCell] {
            (cell.collectionView as UIScrollView).contentOffset.x = position
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return MyRecipeArr.count
    }
    // myRecipe
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let context = AppDelegate.persistentContainer.viewContext
        
        if collectionView.tag == 0 {
            // print(collectionView.tag)
            // print("0", indexPath.section, indexPath.row)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell",
                                                          for: indexPath) as? SearchCollectionViewCell
            
            cell?.recipeName.text = MyRecipeArr[indexPath.row].value(forKey: "name") as! String
            
            
             let this_recipe = MyRecipeArr[indexPath.row] as! Recipe
            /*
             cell?.moreIngredients.text = "You need \(this_recipe.ingredients.count) more ingredients!"*/
            cell?.moreIngredients.text = "this is not fore myRecipe"
            setShadow(UICollectionViewCell: cell!)
            
            // show red heart if favorites
            if(this_recipe.isFav){
                let image = UIImage(named: "icons8-heart-30.png")
                cell?.filledHeart.image = image
            }
            //on checkbox click
            cell?.onClick = { cell in
                if(this_recipe.isFav){
                    // remove from fav list
                    let image = UIImage(named: "")
                    cell.filledHeart.image = image
                    this_recipe.setValue(false, forKey: "isFav")
                }
                else{
                    // add to fav list
                    let image = UIImage(named: "icons8-heart-30.png")
                    cell.filledHeart.image = image
                    this_recipe.setValue(true, forKey: "isFav")
                }
            }
            
            do{ try context.save() }
            catch { print("failed saving @ 1st part of collectionview in searchtableviewcontroller") }
            return cell!
            
        }
        else {
            // print(collectionView.tag)
            // print("1", indexPath.section, indexPath.row)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search2CollectionViewCell",
                                                          for: indexPath) as? Search2CollectionViewCell
            
            
            cell?.recipeName.text = MyRecipeArr[indexPath.row].value(forKey: "name") as! String
            let this_recipe = MyRecipeArr[indexPath.row] as! Recipe
            /*
            cell?.moreIngredients.text = " \(this_recipe.ingredients.count) more ingredients!"*/
            cell?.moreIngredients.text = "this is not fore myRecipe"
            setShadow2(UICollectionViewCell: cell!)
            
            
            // show red heart if favorites
            if(this_recipe.isFav){
                let image = UIImage(named: "icons8-heart-30.png")
                cell?.filledHeart.image = image
            }
            
            //on checkbox click
            cell?.onClick = { cell in
                if(this_recipe.isFav){
                    let image = UIImage(named: "")
                    cell.filledHeart.image = image
                    this_recipe.setValue(false, forKey: "isFav")
                }
                else{
                    // add to fav list
                    let image = UIImage(named: "icons8-heart-30.png")
                    cell.filledHeart.image = image
                    this_recipe.setValue(true, forKey: "isFav")
                }
            }
            
            do{ try context.save() }
            catch { print("failed saving @ 2nd part of collectionview in searchtableviewcontroller ") }
            
            return cell!
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = MyRecipeArr[indexPath.row]
        index = indexPath.row // index is MyRecipeArr's index not RecipeBook's ..
        print(recipe.value(forKey: "name") as! String)
        // index = RecipeBook.index(of: recipe)
        // print(index)
        
        // print(RecipeBook[index!].value(forKey: "name") as! String)
        
        performSegue(withIdentifier: "showDaFullRecipe", sender: index) // sending myRecipeArr's index 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generate_my_and_pot_Recipe()
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
        
        generate_my_and_pot_Recipe()
        
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

