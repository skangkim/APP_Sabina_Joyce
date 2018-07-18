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

// JSON
let p: Parameters = ["api_key": "PkL8Lbt6TnPU5GrTQXZWSHJR0sl38DO6vEmlbFIn", "q" : "Banana", "ds" : "Standard Reference", "max" : "1"]
// var url : String = "/api/foods?query=mango&count=1&start=0&spell=true"

func makeRequest(){
    
    Alamofire.request("https://api.nal.usda.gov/ndb/search", parameters: p).responseJSON { response in
        print("Request: \(String(describing: response.request))")   // original url request
        print("Response: \(String(describing: response.response))") // http url response
        print("Result: \(response.result)")                         // response serialization result
        
        if let json = response.result.value {
            print("JSON: \(json)") // serialized json response
        }
        
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            print("Data: \(utf8Text)") // original server data as UTF8 string
        }
    }
    
}
enum FoodType: Int{
    case Fruit
    case Dairy
    case Poultry
    case Meat
    case Protein_other
    case Seasoning
    case Etc
}

class Ingrd: Hashable{
    var Name : String
    var Ingrd_Type : FoodType
    
    public var hashValue: Int{
        return Name.hashValue
    } // Hash with name
    
    public static func == (lhs: Ingrd, rhs: Ingrd) -> Bool{
        return lhs.Name == rhs.Name
    }
    
    
    init (name_in: String, type_in: FoodType) {
        Name = name_in
        Ingrd_Type = FoodType(rawValue: type_in.rawValue)!
    } // Initilizer with name and food type
    
    init (name_in: String){
        self.Name = name_in
        self.Ingrd_Type = IngredBook[name_in]!
        
    } // Initialize with food name only
}

var myFridge = [Ingrd: Int]() // Ingredients list in User's Fridge
var FruitCount = 0
var DairyCount = 0
var PoultryCount = 0
var MeatCount = 0
var Protein_otherCount = 0
var SeasoningCount = 0
var EtcCount = 0

var IngredBook = [String : FoodType]() // Ingredient Book

func init_IngredBook(){
    IngredBook["Banana"] = FoodType.Fruit
    IngredBook["Milk"] = FoodType.Dairy
    IngredBook["Egg"] = FoodType.Poultry
    IngredBook["Bacon"] = FoodType.Meat
    IngredBook["Chicken"] = FoodType.Meat
    IngredBook["Salt"] = FoodType.Seasoning
}

func possibleIngredients() -> [String] {
    var ingredientNames = [String]()
    for ing in IngredBook {
        ingredientNames.append(ing.key)
    }
    
    return ingredientNames
}


var availRecipe = [Int]() // Stores recipe index that user can make

struct RecipeBookInfo{
    
    var FoodName : String
    
    // List of Food Types
    var FruitList = [Ingrd]()
    var DairyList = [Ingrd]()
    var PoultryList = [Ingrd]()
    var MeatList = [Ingrd]()
    var ProteinEtcList = [Ingrd]()
    var SeasoningList = [Ingrd]()
    var EtcList = [Ingrd]()
    
    var Steps : String
    
    init (name_in: String, array_in: [Ingrd], steps_in: String) {
        
        FoodName = name_in
        Steps = steps_in
        
        for ingred_in in array_in{
            if(ingred_in.Ingrd_Type == FoodType.Fruit){
                FruitList.append(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Dairy){
                DairyList.append(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Poultry){
                PoultryList.append(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Meat){
                MeatList.append(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Protein_other){
                ProteinEtcList.append(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Seasoning){
                SeasoningList.append(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Etc){
                EtcList.append(ingred_in)
            }
        }
    } // Initilizer
}

var RecipeBook = [RecipeBookInfo]() // Recipe Book :D

func initRecipeBook(){
    // banana milk
    let IngrdArray = [Ingrd(name_in: "Banana"), Ingrd(name_in: "Milk")]
    RecipeBook.append(RecipeBookInfo(name_in: "Banana Smoothie", array_in: IngrdArray, steps_in: "Blend Banana and MIlk"))
}

func update_availRecipe(){
    for (index, item) in RecipeBook.enumerated() {
        var count = item.FruitList.count + item.DairyList.count + item.PoultryList.count + item.MeatList.count
            + item.ProteinEtcList.count + item.SeasoningList.count + item.EtcList.count

        if(item.FruitList.count <= FruitCount){
            for j in item.DairyList{
                if(myFridge[j] != nil) {
                    count -= 1
                }
            }
        }
        if(item.DairyList.count <= DairyCount){
            for j in item.FruitList{
                if(myFridge[j] != nil){
                    count -= 1
                }
            }
        }
        if(item.PoultryList.count <= PoultryCount){
            for j in item.PoultryList{
                if(myFridge[j] != nil){
                    count -= 1
                }
            }
        }
        if(item.MeatList.count <= MeatCount){
            for j in item.MeatList{
                if(myFridge[j] != nil){
                    count -= 1
                }
            }
        }
        if(item.ProteinEtcList.count <= Protein_otherCount){
            for j in item.ProteinEtcList{
                if(myFridge[j] != nil){
                    count -= 1
                }
            }
        }
        if(item.SeasoningList.count <= SeasoningCount){
            for j in item.SeasoningList{
                if(myFridge[j] != nil){
                    count -= 1
                }
            }
        }
        if(item.EtcList.count <= EtcCount){
            for j in item.EtcList{
                if(myFridge[j] != nil){
                    count -= 1
                }
            }
        }
        if(count == 0){
            availRecipe.append(index)
            print("You can make: ")
            print(item.FoodName)
        }
    }
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    let myPickerData = [String](arrayLiteral: "Fruit", "Dairy", "Protein", "Seasoning", "Poultry", "Etc")
    
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
    
    @IBOutlet weak var AddIngredientLabel: UILabel!
    @IBOutlet weak var insertButton: UIButton!
    @IBOutlet weak var nameTextField: SearchTextField!
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var moreInfoLabel: UILabel!
    // Database
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Configure a simple search text field
        configureSimpleSearchTextField()
        
        // Enable the Save button only if the text field has a valid Meal name.
//        updateSaveButtonState()
        let thePicker = UIPickerView()
        categoryTextField.inputView = thePicker
        thePicker.delegate = self
        // Handle the text field's user input throught delegate callbacks.
        nameTextField.delegate = self
        
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
        
        makeRequest()
        //add ingredient to array
        let input = nameTextField.text!
        let cat = convertType(ing_in: categoryTextField.text!)
        let input_ingred = Ingrd(name_in: input, type_in: cat)
        
        if myFridge[input_ingred] != nil{
            myFridge[input_ingred]! += 1
        }
        else{
            myFridge[input_ingred] = 1
        }
        
        //add to ingredients list
        IngredBook[input] = cat
        IngredArray.insert(input, at: 0)
        
        // update food group count
        if(input_ingred.Ingrd_Type == FoodType.Fruit){
            FruitCount += 1
        }
        else if(input_ingred.Ingrd_Type == FoodType.Dairy){
            DairyCount += 1
        }
        else if(input_ingred.Ingrd_Type == FoodType.Poultry){
            PoultryCount += 1
        }
        else if(input_ingred.Ingrd_Type == FoodType.Meat){
            MeatCount += 1
        }
        else if(input_ingred.Ingrd_Type == FoodType.Protein_other){
            Protein_otherCount += 1
        }
        else if(input_ingred.Ingrd_Type == FoodType.Seasoning){
            SeasoningCount += 1
        }
        else if(input_ingred.Ingrd_Type == FoodType.Etc){
            EtcCount += 1
        }
        
        let banner = Banner(title: "Success!", subtitle: "Added " + nameTextField.text! + " to ingredients list.", image: UIImage(named: "Icon"), backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000))
        banner.dismissesOnTap = true
        banner.show(duration: 3.0)
        
        print(IngredBook)
        print(IngredArray)
        // update availRecipe
        update_availRecipe()
        
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
            item.subtitle = FTtoSTRING(ing_in: IngredBook[self.nameTextField.text!]!)
            self.categoryTextField.text = FTtoSTRING(ing_in: IngredBook[self.nameTextField.text!]!)
            self.nameTextField.resignFirstResponder()
            self.nameTextField.hideResultsList()
            self.moreInfoLabel.text = item.subtitle
        }
        
        // Set data source
        let possibleIng = possibleIngredients()
        nameTextField.filterStrings(possibleIng)
    }

}

func convertType(ing_in: String) -> FoodType {
    if(ing_in == "Fruit") {
        return FoodType.Fruit
    }
    if(ing_in == "Dairy") {
        return FoodType.Dairy
    }
    if(ing_in == "Poultry") {
        return FoodType.Poultry
    }
    if(ing_in == "Meat") {
        return FoodType.Meat
    }
    if(ing_in == "Protein_other") {
        return FoodType.Protein_other
    }
    if(ing_in == "Seasoning") {
        return FoodType.Seasoning
    }
    return FoodType.Etc
}
func FTtoSTRING(ing_in: FoodType) -> String {
    if(ing_in == FoodType.Fruit) {
        return "Fruit"
    }
    if(ing_in == FoodType.Dairy) {
        return "Dairy"
    }
    if(ing_in == FoodType.Poultry) {
        return "Poultry"
    }
    if(ing_in == FoodType.Meat) {
        return "Meat"
    }
    if(ing_in == FoodType.Protein_other) {
        return "Protein_other"
    }
    if(ing_in == FoodType.Seasoning) {
        return "Seasoning"
    }
    return "Etc"
}
