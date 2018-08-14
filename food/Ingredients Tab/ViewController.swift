//
//  ViewController.swift
//  food
//
//  Created by J Lee on 7/7/18.
//  Copyright © 2018 J Lee. All rights reserved.
//
import UIKit
import os.log
import SearchTextField
import BRYXBanner
import Alamofire
import HexColors
import CoreData


var IngredBook = [Ingred]()
var RecipeBook = [Recipe]()

func init_RecipeBook(){
    
    // TODO: make an excel file and store recipe -> parse JSON
    let context = AppDelegate.viewContext
    let e_recipe = NSEntityDescription.entity(forEntityName: "RecipeBook", in: context)
    

    let banana = "banana"
    let milk = "milk"
    let bluberry = "blueberry"
    
    AppDelegate.persistentContainer.performBackgroundTask{ context in
        do{
            // banana smoothie
            let banana_smoothie = Recipe(entity: e_recipe!, insertInto: context)
            banana_smoothie.name = "banana smoothie"
            banana_smoothie.steps = "grind banana and milk"
            let fetchIngred = NSFetchRequest<Ingred>(entityName: "Ingred")
            fetchIngred.predicate = NSPredicate(format: "name contains [c] %@", banana)
            // for each ingredients
            // banana
            let e_banana = NSEntityDescription.entity(forEntityName: "IngredInfo", in: context)
            let banana_info = IngredInfo(entity: e_banana!, insertInto: context)
            try banana_info.ingredients = context.fetch(fetchIngred)[0] // only one banana type
            banana_info.quantity = 1
            banana_info.unit = IngredInfo.Unit.count
            banana_smoothie.addToIngredients(banana_info)
            // milk
            fetchIngred.predicate = NSPredicate(format: "name contains [c] %@", milk)
            let e_milk = NSEntityDescription.entity(forEntityName: "IngredInfo", in: context)
            let milk_info = IngredInfo(entity: e_milk!, insertInto: context)
            try milk_info.ingredients = context.fetch(fetchIngred)[0] // TODO: remove "soy" milk etc
            milk_info.quantity = 3
            milk_info.unit = IngredInfo.Unit.oz
            banana_smoothie.addToIngredients(milk_info)
        }
        catch let error as NSError{
            print(error)
        }
        // MARK: edit this
        // don't forget to save
        // do{ try context.save() }
        // catch{ print(error) }
    }
    
    

    
    AppDelegate.persistentContainer.performBackgroundTask{ context in
        do{
            // bluberry smoothie
            let blueberry_smoothie = Recipe(entity: e_recipe!, insertInto: context)
            blueberry_smoothie.name = "blueberry smoothie"
            blueberry_smoothie.steps = "grind bluberry and milk"
            let fetchIngred = NSFetchRequest<Ingred>(entityName: "Ingred")
            fetchIngred.predicate = NSPredicate(format: "name contains [c] %@", bluberry)
            // for each ingredients
            // banana
            let e_bluberry = NSEntityDescription.entity(forEntityName: "IngredInfo", in: context)
            let bluberry_info = IngredInfo(entity: e_bluberry!, insertInto: context)
            try bluberry_info.ingredients = context.fetch(fetchIngred)[0]
            bluberry_info.quantity = 1
            bluberry_info.unit = IngredInfo.Unit.count
            blueberry_smoothie.addToIngredients(bluberry_info)
            // milk
            fetchIngred.predicate = NSPredicate(format: "name contains [c] %@", milk)
            let e_milk = NSEntityDescription.entity(forEntityName: "IngredInfo", in: context)
            let milk_info = IngredInfo(entity: e_milk!, insertInto: context)
            try milk_info.ingredients = context.fetch(fetchIngred)[0]
            milk_info.quantity = 3
            milk_info.unit = IngredInfo.Unit.oz
            blueberry_smoothie.addToIngredients(milk_info)
        }
        catch let error as NSError{
            print(error)
        }
        // TODO: edit saving
        // don't forget to save
        // do{ try context.save() }
        // catch{ print(error) }
    }
    
    // add all to recipeBook
    AppDelegate.persistentContainer.performBackgroundTask{ context in
        do{
            let fetchRecipe = NSFetchRequest<Recipe>(entityName: "Recipe")
            fetchRecipe.predicate = NSPredicate(format: "ALL")
            let fetchResult = try context.fetch(fetchRecipe)
            for recipe in fetchResult{
                RecipeBook.append(recipe)
            }
        }
        catch let error as NSError{
            print(error)
        }
        // don't forget to save
        do{ try context.save() }
        catch{ print(error) }
    }
    
}

struct Ing_Json: Decodable{
    let name : String
    let foodType : String
    let TF : Bool
}

func init_IngredBook(){
    let context = AppDelegate.viewContext
    let e_ingred = NSEntityDescription.entity(forEntityName: "Ingred", in: context)
    
    
    if let path = Bundle.main.path(forResource: "ingredients", ofType: "json"){
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options:.mappedIfSafe)
            let jsonDecode = try JSONDecoder().decode([Ing_Json].self, from: data)
            for i in jsonDecode{
                // do
                let request = NSFetchRequest<Ingred>(entityName: "Ingred")
                request.predicate = NSPredicate(format: "name = %@", i.name)
                let fetch_result = try context.fetch(request)
                if (fetch_result.isEmpty){
                    continue // already exists in the ingredient
                }
                let ingrd = Ingred(entity: e_ingred!, insertInto: context)
                ingrd.name = i.name
                ingrd.inFridge = false
                if(i.foodType == "dairy"){
                    ingrd.foodType = Ingred.FoodType.Dairy
                }
                else if(i.foodType == "veg"){
                    ingrd.foodType = Ingred.FoodType.Veggie
                }
                else if(i.foodType == "fruits"){
                    ingrd.foodType = Ingred.FoodType.Fruits
                }
                else if(i.foodType == "baking"){
                    ingrd.foodType = Ingred.FoodType.BakedNGrains
                }
                else if(i.foodType == "seasonings"){
                    ingrd.foodType = Ingred.FoodType.Seasonings
                }
                else if(i.foodType == "meat"){
                    ingrd.foodType = Ingred.FoodType.Meat
                }
                else if(i.foodType == "seafood"){
                    ingrd.foodType = Ingred.FoodType.Seafood
                }
                else if(i.foodType == "oils"){
                    ingrd.foodType = Ingred.FoodType.Oils
                }
                else if(i.foodType == "legume"){
                    ingrd.foodType = Ingred.FoodType.Legume
                }
                else if(i.foodType == "soup"){
                    ingrd.foodType = Ingred.FoodType.Soup
                }
                else if(i.foodType == "nuts"){
                    ingrd.foodType = Ingred.FoodType.Nut
                }
                else if(i.foodType == "dairyAlt"){
                    ingrd.foodType = Ingred.FoodType.DairyAlt
                }
                else if (i.foodType == "beverages"){
                    ingrd.foodType = Ingred.FoodType.Beverages
                }
            }
        }
        catch{
            print("in init IngredBook, error is : \(error) ")
        }
    }
    // don't forget to save
    do{ try context.save() }
    catch{ print(error) }
}

func setCardView(view : UIView){
    view.layer.masksToBounds = false
    view.layer.shadowOffset = CGSize(width: 0, height: 3)
    view.layer.shadowRadius = 2
    view.layer.shadowOpacity = 0.5
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    let myPickerData = [String](arrayLiteral: "Dairy", "Fruits", "Veggie", "Baked Goods & Grains", "Seasonings", "Legume", "Meat", "Seafood", "Nut", "Oils", "Soup", "Dairy Alternatives", "Beverages")
    
    @IBOutlet weak var viewCell: UIView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextField.text = myPickerData[row]
        moreInfoLabel.text = myPickerData[row]
        categoryTextField.resignFirstResponder()
    }
    func pickerView( _ pickerView: UIPickerView) {
        textFieldShouldReturn(categoryTextField)
        
    }
    
    //MARK: Properties
    
    @IBOutlet weak var insertButton: UIButton!
    @IBOutlet weak var nameTextField: SearchTextField!
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var moreInfoLabel: UILabel!
    // Database
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Configure a simple search text field
        configureSimpleSearchTextField()
        
        // MARK: init ingredients
        // MARK: init recipe book
        
        
        
        // Enable the Save button only if the text field has a valid Meal name.
        //        updateSaveButtonState()
        let thePicker = UIPickerView()
        categoryTextField.inputView = thePicker
        thePicker.delegate = self
        // Handle the text field's user input throught delegate callbacks.
        nameTextField.delegate = self
//        setCardView(view: viewCell)
//        viewCell.backgroundColor = UIColor("FFAF87")
        
    }
    
    @IBOutlet weak var addButton: UIView!
    override func viewWillAppear(_ animated: Bool) {
        addButton.layer.shadowOpacity = 0.7
        addButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        addButton.layer.shadowRadius = 8.0
        addButton.layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {

        textFieldShouldReturn(nameTextField)
        
    }
    //MARK: Actions
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        //add ingredient to array
        let input = nameTextField.text! // input ingred name
        
        let request: NSFetchRequest<Ingred> = Ingred.fetchRequest()
        request.predicate = NSPredicate(format: "Ingred.name = %@", input)
        
        AppDelegate.persistentContainer.performBackgroundTask{ context in
            do {
                let fetchResult = try context.fetch(request)
                if fetchResult.count > 0 {
                    assert(fetchResult.count > 1, "addButtonTapped -- database inconsistency")
                    if(!fetchResult[0].inFridge) {
                        fetchResult[0].inFridge = true
                        fridge.append(fetchResult[0])
                        // not already in the fridge
                    }
                }
            }
            catch{
                print("error")
            }
            
            // don't forget to save
            do{ try context.save() }
            catch{ print(error) }
        }
        
        
        let banner = Banner(title: "Success!", subtitle: "Added " + nameTextField.text! + " to ingredients list.", image: UIImage(named: "Icon"), backgroundColor: UIColor("#0c9b00")!)
        banner.dismissesOnTap = true
        banner.show(duration: 3.0)
        
        
        nameTextField.text = nil
        categoryTextField.text = nil
        
        
    }
    
    // 1 - Configure a simple search text view
    fileprivate func configureSimpleSearchTextField() {
        // Start visible even without user's interaction as soon as created - Default: false
        nameTextField.startVisibleWithoutInteraction = false
        
        //        // Set specific comparision options - Default: .caseInsensitive
        //        nameTextField.comparisonOptions = [.caseInsensitive]
        //
        //        // You can also limit the max height of the results list
        //        nameTextField.maxResultsListHeight = 10
        
        // Set the max number of results. By default it's not limited
        nameTextField.maxNumberOfResults = 5
        
        nameTextField.theme.font = UIFont.systemFont(ofSize: 16)
        
        // Handle item selection - Default behaviour: item title set to the text field
        nameTextField.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            // Do whatever you want with the picked item
            self.nameTextField.text = item.title
            // set subtitle to food type given ingred name
            let request: NSFetchRequest<Ingred> = Ingred.fetchRequest()
            request.predicate = NSPredicate(format: "Ingred.name = %@", item.title)
            AppDelegate.persistentContainer.performBackgroundTask{ context in
                do {
                    let fetchResult = try context.fetch(request)
                    if fetchResult.count > 0 {
                        assert(fetchResult.count > 1, "addButtonTapped -- database inconsistency")
                        item.subtitle = "\(fetchResult[0].foodType)"
                        self.categoryTextField.text = "\(fetchResult[0].foodType)"
                    }
                }
                catch let error as NSError{
                    print(error)
                }
            }
            self.nameTextField.resignFirstResponder()
            self.nameTextField.hideResultsList()
            self.moreInfoLabel.text = item.subtitle
        }
        
        let request: NSFetchRequest<Ingred> = Ingred.fetchRequest()
        // Set data source
        var ingredDropDown = [String]()
        request.predicate = NSPredicate(format: "ALL")
        AppDelegate.persistentContainer.performBackgroundTask{context in
            do{
                
                let fetchResult = try context.fetch(request)
                for i in fetchResult{
                    ingredDropDown.append(i.name)
                }
            }
            catch let error as NSError{
                print(error)
            }
        }
        nameTextField.filterStrings(ingredDropDown)
    }
}


