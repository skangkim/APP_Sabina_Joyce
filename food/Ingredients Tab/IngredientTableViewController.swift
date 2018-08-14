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


var IngredBook = [NSManagedObject]()
var RecipeBook = [NSManagedObject]()

var fridge = [NSManagedObject]()
// global variable
// Limit to the number of ingredients that user need to buy to generate potential recipe
let POT_REP_LIMIT = 2

struct Ingred_JSON: Decodable{
    let name: String
    let foodType: String
    let inF: String
    private enum CodingKeys: String, CodingKey{
        case name = "Name"
        case foodType = "FT"
        case inF = "inFridge"
    }
}

func preload_data(){
    let context = AppDelegate.persistentContainer.viewContext
    delete_all_database()
    init_IngredBook()
    init_RecipeBook()
}

func delete_all_database(){
    AppDelegate.persistentContainer.performBackgroundTask{ context in
        do{
            let req = NSFetchRequest<Ingred>(entityName: "Ingred")
            do{
                let objs = try context.fetch(req)
                for obj in objs{
                    context.delete(obj)
                }
            }
            let req1 = NSFetchRequest<Recipe>(entityName: "Recipe")
            do{
                let objs = try context.fetch(req1)
                for obj in objs{
                    context.delete(obj)
                }
            }
            let req2 = NSFetchRequest<PotRecipe>(entityName: "PotRecipe")
            do{
                let objs = try context.fetch(req2)
                for obj in objs{
                    context.delete(obj)
                }
            }
            let req3 = NSFetchRequest<IngredInfo>(entityName: "IngredInfo")
            do{
                let objs = try context.fetch(req3)
                for obj in objs{
                    context.delete(obj)
                }
            }
        }
        catch let error as NSError{
            print(error)
        }
        
        do{
            try context.save()
        }
        catch{
            print("failed saving")
        }
    }
}
func init_RecipeBook(){
    // do something
    print("initializing recipe book....")
    let context = AppDelegate.viewContext
    let e_recipe = NSEntityDescription.entity(forEntityName: "Recipe", in: context)
    let e_ingredInfo = NSEntityDescription.entity(forEntityName: "IngredInfo", in: context)
    let blueberryshake = Recipe(entity: e_recipe!, insertInto: context)
    do{
        blueberryshake.setValue(false, forKey: "isFav")
        blueberryshake.setValue("blueberry shake", forKey: "name")
        blueberryshake.setValue("get blueberry and pour milk and mix mix mix it!", forKey: "steps")
        var ingred_set = Set<NSManagedObject>()
        // add ingredients
        // 1. blueberry
        let request = NSFetchRequest<Ingred>(entityName: "Ingred")
        request.predicate = NSPredicate(format: "name == %@", "blueberry")
        let blueberry = try context.fetch(request)
        assert(blueberry.count <= 1, "database inconsistency")
        if(blueberry.count == 0){
            print("blueberry not found")
        }
        let info1 = IngredInfo(entity: e_ingredInfo!, insertInto: context)
        info1.setValue(3, forKey: "quantity")
        info1.setValue(IngredInfo.Unit.count.rawValue, forKey: "unit")
        info1.setValue(false, forKey: "isSL")
        info1.setValue(blueberry[0], forKey: "ingredients")
        ingred_set.insert(info1)
        // 2. milk
        request.predicate = NSPredicate(format: "name == %@", "milk")
        let milk = try context.fetch(request)
        assert(milk.count <= 1, "milk inconsistency")
        if(milk.count == 0){
            print("milk not found ")
        }
        let info2 = IngredInfo(entity: e_ingredInfo!, insertInto: context)
        info2.setValue(8, forKey: "quantity")
        info2.setValue(IngredInfo.Unit.oz.rawValue, forKey: "unit")
        info2.setValue(false, forKey: "isSL")
        info2.setValue(milk[0], forKey: "ingredients")
        ingred_set.insert(info2)
        blueberryshake.ingredients = NSSet(set: ingred_set)
        print(blueberryshake.ingredients.count)
    }
    catch{
        print("error @ init_RecipeBook :: \(error)")
    }
    do{ try context.save() }
    catch let error as NSError { print("failed saving @ init_recipebook :'( error: \(error)") }
}

func init_IngredBook(){
    let context = AppDelegate.viewContext
    let e_ingred = NSEntityDescription.entity(forEntityName: "Ingred", in: context)

    
    if let path = Bundle.main.path(forResource: "ingredients", ofType: "json"){
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options:.alwaysMapped)
            let jsonDecode = try JSONDecoder().decode([Ingred_JSON].self, from: data)
            for i in jsonDecode{
                let ingrd = Ingred(entity: e_ingred!, insertInto: context)
                ingrd.setValue(i.name, forKey: "name")
                ingrd.setValue(false, forKey: "inFridge")
                if(i.foodType == "dairy"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.Dairy.rawValue)!.rawValue
                }
                else if(i.foodType == "veg"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.Veggie.rawValue)!.rawValue
                }
                else if(i.foodType == "fruits"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.Fruits.rawValue)!.rawValue
                }
                else if(i.foodType == "baking"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.BakedNGrains.rawValue)!.rawValue
                }
                else if(i.foodType == "seasonings"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.Seasonings.rawValue)!.rawValue
                }
                else if(i.foodType == "meat"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.Meat.rawValue)!.rawValue
                }
                else if(i.foodType == "seafood"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.Seafood.rawValue)!.rawValue
                }
                else if(i.foodType == "oils"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.Oils.rawValue)!.rawValue
                }
                else if(i.foodType == "legume"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.Legume.rawValue)!.rawValue
                }
                else if(i.foodType == "soup"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.Soup.rawValue)!.rawValue
                }
                else if(i.foodType == "nuts"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.Nut.rawValue)!.rawValue
                }
                else if(i.foodType == "dairyAlt"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.DairyAlt.rawValue)!.rawValue
                }
                else if (i.foodType == "beverages"){
                    ingrd.foodType = Ingred.FoodType(rawValue: Ingred.FoodType.Beverages.rawValue)!.rawValue
                }
                else{
                    print("foodtype input error")
                }
                
                IngredBook.append(ingrd)
            }
            do{ try context.save() }
            catch { print("failed saving @ init ingredbook") }
        }
        catch{
            print("in init IngredBook, error is : \(error) ")
        }
    }
}

func fetch_fridge(){
    fridge = []
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedObjectContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Ingred")
    let pred = NSPredicate(format: "inFridge == %@", NSNumber(value: true))
    fetchRequest.predicate = pred
    do {
        fridge = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
    } catch let error as NSError {
        print("Could not fetch. \(error)")
    }
}

class IngredientTableViewController: UITableViewController {
    
    //MARK: Properties

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch_fridge()
        
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
        fetch_fridge()
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
        let ing = fridge[indexPath.row]
        cell.nameLabel.text = ing.value(forKey: "name") as! String

        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            
            let context = AppDelegate.persistentContainer.viewContext
            
            let del = fridge[indexPath.row]
            del.setValue(false, forKey: "inFridge")
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            // save changes
            do{ try context.save() }
            catch let error as NSError{ print("couldnt set isFridge == false. Error: \(error)") }
            
            // delete from fridge
            fridge.remove(at: indexPath.row)
            // save
            
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
