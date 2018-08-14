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
        let input = nameTextField.text!
        
        let request:NSFetchRequest<Ingred> = Ingred.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", input)
        
        AppDelegate.persistentContainer.performBackgroundTask{ context in
            do{
                let result = try context.fetch(request)
                assert(result.count == 1, "addbuttontapped - database inconsistency")
                result[0].inFridge = true
            }
            catch let error as NSError{
                print("error in add button tapped and the error is: \(error)")
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
        
            var ft = Int32(-1)// subtitle = foodtype
            item.subtitle = self.nameTextField.text!
            let request: NSFetchRequest<Ingred> = Ingred.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@", self.nameTextField.text!)
            AppDelegate.persistentContainer.performBackgroundTask{ context in
                do{
                    let result = try context.fetch(request)
                    assert(result.count == 1, "Inconsistent data consistency")
                    ft = result[0].foodType
                }
                catch{
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self.categoryTextField.text = getFoodTypeString(rawValue_in: ft)
            }
            
            self.categoryTextField.text = self.nameTextField.text!
            // self.categoryTextField.text = FTtoSTRING(ing_in: IngredBook[self.nameTextField.text!]!)
            self.nameTextField.resignFirstResponder()
            self.nameTextField.hideResultsList()
            self.moreInfoLabel.text = item.subtitle
        }
        
        var ingredDropDown = [String]()
        for i in IngredBook{
            ingredDropDown.append(i.value(forKey: "name") as! String)
        }
        self.nameTextField.filterStrings(ingredDropDown)
        /*
        DispatchQueue.main.async {
            // Set data source
            var ingredDropDown = [String]()
            for i in IngredBook{
                ingredDropDown.append(i.name)
            }
            self.nameTextField.filterStrings(ingredDropDown)
        }*/
    }
    
}


func getFoodTypeString(rawValue_in: Int32) -> String{
    let group = Ingred.FoodType(rawValue: rawValue_in)!
    switch group {
    case .Dairy:
        return "Dairy"
    case .Fruits:
        return "Fruits"
    case .Veggie:
        return"Veggetables"
    case .BakedNGrains:
        return "Baked and grains"
    case .Seasonings:
        return "Seasonings"
    case .Meat:
        return "Meat"
    case .Seafood:
        return "Seafood"
    case .Legume:
        return "Legumes"
    case .Nut:
        return "Nuts"
    case .Oils:
        return "Oils"
    case .Soup:
        return "Soup"
    case .DairyAlt:
        return "Dairy Alternatives"
    default:
        return ""
    }
    
}
