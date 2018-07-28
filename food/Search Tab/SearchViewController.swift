//
//  ViewController.swift
//  food
//
//  Created by J Lee on 7/24/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit




class SearchViewController: UIViewController {
    
    var index: Int?
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var steps: UILabel!
    
    
    // assuming that index (index of RecipeBook) is in potential recipe
    
    @IBAction func addShoppingListTapped(_ sender: UIButton) {
        
        var arr = [(Ingrd, foodMeasureUnit)]()
        for i in RecipeBook[index!].DairyList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        for i in RecipeBook[index!].FruitsList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        for i in RecipeBook[index!].VeggieList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        for i in RecipeBook[index!].BakedNGrainsList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        for i in RecipeBook[index!].SeasoningsList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        for i in RecipeBook[index!].MeatList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        for i in RecipeBook[index!].SeafoodList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        for i in RecipeBook[index!].LegumeList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        for i in RecipeBook[index!].NutList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        for i in RecipeBook[index!].OilsList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        for i in RecipeBook[index!].SoupList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        for i in RecipeBook[index!].DairyAltList{
            if(!myFridge.contains(i.0)){
                // need this ingredient
                arr.append(i)
            }
        }
        let OS = NSOrderedSet(array: arr)
        print("add to shopping list !!!!")
        
        
        shoppingListArray.append((index!, OS))
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor("FFAF87")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        //        //get rid of bottom line of navigation
        //        let navigationBar = navigationController!.navigationBar
        //        navigationBar.isTranslucent = false
        //        navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        navigationBar.shadowImage = UIImage()
        
        //setting the page info 
        print(RecipeBook[index!].FoodName)
        recipeName.text = RecipeBook[index!].FoodName
        steps.text = RecipeBook[index!].Steps
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
