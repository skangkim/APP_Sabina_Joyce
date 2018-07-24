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

enum FoodType: Int{
    case Dairy
    case Fruits
    case Veggie
    case BakedNGrains
    case Seasonings
    case Meat
    case Seafood
    case Legume
    case Nut
    case Oils
    case Soup
    case DairyAlt
    case Beverages
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


var myFridge = [Ingrd]() // Ingredients list in User's Fridge
var IngredBook = [String : FoodType]() // Ingredient Book
func init_IngredBook(){
    
    IngredBook["butter"] = FoodType.Dairy
    IngredBook["egg"] = FoodType.Dairy
    IngredBook["milk"] = FoodType.Dairy
    IngredBook["parmesan cheese"] = FoodType.Dairy
    IngredBook["cheddar cheese"] = FoodType.Dairy
    IngredBook["american cheese"] = FoodType.Dairy
    IngredBook["sour cream"] = FoodType.Dairy
    IngredBook["mozzarella"] = FoodType.Dairy
    IngredBook["yogurt"] = FoodType.Dairy
    IngredBook["cream"] = FoodType.Dairy
    IngredBook["cream cheese"] = FoodType.Dairy
    IngredBook["whipped cream"] = FoodType.Dairy
    IngredBook["feta cheese"] = FoodType.Dairy
    IngredBook["condensed milk"] = FoodType.Dairy
    IngredBook["ice cream"] = FoodType.Dairy
    IngredBook["frosting"] = FoodType.Dairy
    IngredBook["ricotta"] = FoodType.Dairy
    IngredBook["goat cheese"] = FoodType.Dairy
    IngredBook["blue cheese"] = FoodType.Dairy
    IngredBook["powdered milk"] = FoodType.Dairy
    IngredBook["pizza cheese"] = FoodType.Dairy
    
    IngredBook["onion"] = FoodType.Veggie
    IngredBook["garlic"] = FoodType.Veggie
    IngredBook["tomato"] = FoodType.Veggie
    IngredBook["potato"] = FoodType.Veggie
    IngredBook["carrot"] = FoodType.Veggie
    IngredBook["bell pepper"] = FoodType.Veggie
    IngredBook["basil"] = FoodType.Veggie
    IngredBook["parsley"] = FoodType.Veggie
    IngredBook["broccoli"] = FoodType.Veggie
    IngredBook["corn"] = FoodType.Veggie
    IngredBook["spinach"] = FoodType.Veggie
    IngredBook["mushroom"] = FoodType.Veggie
    IngredBook["green beans"] = FoodType.Veggie
    IngredBook["ginger"] = FoodType.Veggie
    IngredBook["chili pepper"] = FoodType.Veggie
    IngredBook["celery"] = FoodType.Veggie
    IngredBook["rosemary"] = FoodType.Veggie
    IngredBook["salad greens"] = FoodType.Veggie
    IngredBook["red onion"] = FoodType.Veggie
    IngredBook["cucumber"] = FoodType.Veggie
    IngredBook["sweet potato"] = FoodType.Veggie
    IngredBook["pickle"] = FoodType.Veggie
    IngredBook["avocado"] = FoodType.Veggie
    IngredBook["zucchini"] = FoodType.Veggie
    IngredBook["cilantro"] = FoodType.Veggie
    IngredBook["olive"] = FoodType.Veggie
    IngredBook["asparagus"] = FoodType.Veggie
    IngredBook["cabbage"] = FoodType.Veggie
    IngredBook["cauliflower"] = FoodType.Veggie
    IngredBook["dill"] = FoodType.Veggie
    IngredBook["kale"] = FoodType.Veggie
    IngredBook["pumpkin"] = FoodType.Veggie
    IngredBook["squash"] = FoodType.Veggie
    IngredBook["mint"] = FoodType.Veggie
    IngredBook["scallion"] = FoodType.Veggie
    IngredBook["shallot"] = FoodType.Veggie
    IngredBook["eggplant"] = FoodType.Veggie
    IngredBook["beet"] = FoodType.Veggie
    IngredBook["leek"] = FoodType.Veggie
    IngredBook["caper"] = FoodType.Veggie
    IngredBook["brussels sprout"] = FoodType.Veggie
    IngredBook["artichoke heart"] = FoodType.Veggie
    IngredBook["chia seeds"] = FoodType.Veggie
    IngredBook["radish"] = FoodType.Veggie
    IngredBook["portobello mushroom"] = FoodType.Veggie
    IngredBook["sweet pepper"] = FoodType.Veggie
    IngredBook["arugula"] = FoodType.Veggie
    IngredBook["spaghetti squash"] = FoodType.Veggie
    IngredBook["bok shoy"] = FoodType.Veggie
    IngredBook["parsnip"] = FoodType.Veggie
    IngredBook["okra"] = FoodType.Veggie
    IngredBook["yam"] = FoodType.Veggie
    IngredBook["bean sprouts"] = FoodType.Veggie
    IngredBook["seaweed"] = FoodType.Veggie
    IngredBook["collard"] = FoodType.Veggie
    IngredBook["canned tomato"] = FoodType.Veggie
    IngredBook["celery"] = FoodType.Veggie
    IngredBook["kimchi"] = FoodType.Veggie
    
    IngredBook["lemon"] = FoodType.Fruits
    IngredBook["apple"] = FoodType.Fruits
    IngredBook["banana"] = FoodType.Fruits
    IngredBook["lime"] = FoodType.Fruits
    IngredBook["strawberry"] = FoodType.Fruits
    IngredBook["orange"] = FoodType.Fruits
    IngredBook["pineapple"] = FoodType.Fruits
    IngredBook["blueberry"] = FoodType.Fruits
    IngredBook["raisin"] = FoodType.Fruits
    IngredBook["coconut"] = FoodType.Fruits
    IngredBook["grape"] = FoodType.Fruits
    IngredBook["peach"] = FoodType.Fruits
    IngredBook["raspberry"] = FoodType.Fruits
    IngredBook["cranberry"] = FoodType.Fruits
    IngredBook["mango"] = FoodType.Fruits
    IngredBook["pear"] = FoodType.Fruits
    IngredBook["blackberry"] = FoodType.Fruits
    IngredBook["cherry"] = FoodType.Fruits
    IngredBook["date"] = FoodType.Fruits
    IngredBook["watermelon"] = FoodType.Fruits
    IngredBook["berries"] = FoodType.Fruits
    IngredBook["kiwi"] = FoodType.Fruits
    IngredBook["grapefruit"] = FoodType.Fruits
    IngredBook["mandarin"] = FoodType.Fruits
    IngredBook["cantaloupe"] = FoodType.Fruits
    IngredBook["plum"] = FoodType.Fruits
    IngredBook["apricot"] = FoodType.Fruits
    IngredBook["clementine"] = FoodType.Fruits
    IngredBook["prunes"] = FoodType.Fruits
    IngredBook["pomegranate"] = FoodType.Fruits
    IngredBook["nectarine"] = FoodType.Fruits
    IngredBook["tangerine"] = FoodType.Fruits
    IngredBook["fig"] = FoodType.Fruits
    IngredBook["papaya"] = FoodType.Fruits
    IngredBook["currant"] = FoodType.Fruits
    IngredBook["passion fruit"] = FoodType.Fruits
    IngredBook["guava"] = FoodType.Fruits
    IngredBook["lychee"] = FoodType.Fruits
    IngredBook["star fruit"] = FoodType.Fruits
    
    IngredBook["rice"] = FoodType.BakedNGrains
    IngredBook["pasta"] = FoodType.BakedNGrains
    IngredBook["flour"] = FoodType.BakedNGrains
    IngredBook["bread"] = FoodType.BakedNGrains
    IngredBook["baking powder"] = FoodType.BakedNGrains
    IngredBook["baking soda"] = FoodType.BakedNGrains
    IngredBook["cornstarch"] = FoodType.BakedNGrains
    IngredBook["bread crumbs"] = FoodType.BakedNGrains
    IngredBook["rolled oats"] = FoodType.BakedNGrains
    IngredBook["noodle"] = FoodType.BakedNGrains
    IngredBook["flour tortillas"] = FoodType.BakedNGrains
    IngredBook["pancake mix"] = FoodType.BakedNGrains
    IngredBook["yeast"] = FoodType.BakedNGrains
    IngredBook["cracker"] = FoodType.BakedNGrains
    IngredBook["quinoa"] = FoodType.BakedNGrains
    IngredBook["brown rice"] = FoodType.BakedNGrains
    IngredBook["cornmeal"] = FoodType.BakedNGrains
    IngredBook["cake mix"] = FoodType.BakedNGrains
    IngredBook["saltines"] = FoodType.BakedNGrains
    IngredBook["popcorn"] = FoodType.BakedNGrains
    IngredBook["corn tortillas"] = FoodType.BakedNGrains
    IngredBook["ramen"] = FoodType.BakedNGrains
    IngredBook["cereal"] = FoodType.BakedNGrains
    IngredBook["biscuits"] = FoodType.BakedNGrains
    IngredBook["stuffing mix"] = FoodType.BakedNGrains
    IngredBook["pie crust"] = FoodType.BakedNGrains
    IngredBook["chips"] = FoodType.BakedNGrains
    IngredBook["coconut flake"] = FoodType.BakedNGrains
    IngredBook["bread flour"] = FoodType.BakedNGrains
    IngredBook["pizza dough"] = FoodType.BakedNGrains
    IngredBook["hot dog bun"] = FoodType.BakedNGrains
    IngredBook["multigrain bread"] = FoodType.BakedNGrains
    IngredBook["potato flakes"] = FoodType.BakedNGrains
    IngredBook["pretzel"] = FoodType.BakedNGrains
    IngredBook["cornbread"] = FoodType.BakedNGrains
    IngredBook["muffin"] = FoodType.BakedNGrains
    IngredBook["risotto"] = FoodType.BakedNGrains
    IngredBook["ravioli"] = FoodType.BakedNGrains
    IngredBook["wheat"] = FoodType.BakedNGrains
    IngredBook["rice flour"] = FoodType.BakedNGrains
    IngredBook["bread dough"] = FoodType.BakedNGrains
    IngredBook["yeast flake"] = FoodType.BakedNGrains
    IngredBook["breadsticks"] = FoodType.BakedNGrains
    IngredBook["starch"] = FoodType.BakedNGrains
    IngredBook["whole weat flour"] = FoodType.BakedNGrains
    
    
    IngredBook["sugar"] = FoodType.Seasonings
    IngredBook["honey"] = FoodType.Seasonings
    IngredBook["maple syrup"] = FoodType.Seasonings
    IngredBook["corn syrup"] = FoodType.Seasonings
    IngredBook["artifical sweetener"] = FoodType.Seasonings
    IngredBook["cinnamon"] = FoodType.Seasonings
    IngredBook["vanilla"] = FoodType.Seasonings
    IngredBook["garlic powder"] = FoodType.Seasonings
    IngredBook["chili powder"] = FoodType.Seasonings
    IngredBook["cumin"] = FoodType.Seasonings
    IngredBook["italian seasoning"] = FoodType.Seasonings
    IngredBook["onion powder"] = FoodType.Seasonings
    IngredBook["nutmeg"] = FoodType.Seasonings
    IngredBook["curry powder"] = FoodType.Seasonings
    IngredBook["taco seasoning"] = FoodType.Seasonings
    IngredBook["clove"] = FoodType.Seasonings
    IngredBook["chive"] = FoodType.Seasonings
    IngredBook["peppercorn"] = FoodType.Seasonings
    IngredBook["vanilla essence"] = FoodType.Seasonings
    IngredBook["herbs"] = FoodType.Seasonings
    IngredBook["steak seasoning"] = FoodType.Seasonings
    IngredBook["poultry seasoning"] = FoodType.Seasonings
    IngredBook["cardamom"] = FoodType.Seasonings
    IngredBook["italian herbs"] = FoodType.Seasonings
    IngredBook["chipotle"] = FoodType.Seasonings
    IngredBook["cacao"] = FoodType.Seasonings
    IngredBook["chili paste"] = FoodType.Seasonings
    IngredBook["lavendar"] = FoodType.Seasonings
    
    IngredBook["chicken breast"] = FoodType.Meat
    IngredBook["ground beef"] = FoodType.Meat
    IngredBook["bacon"] = FoodType.Meat
    IngredBook["sausage"] = FoodType.Meat
    IngredBook["beef stake"] = FoodType.Meat
    IngredBook["ham"] = FoodType.Meat
    IngredBook["hot dog"] = FoodType.Meat
    IngredBook["pork chops"] = FoodType.Meat
    IngredBook["chicken thighs"] = FoodType.Meat
    IngredBook["ground turkey"] = FoodType.Meat
    IngredBook["turkey"] = FoodType.Meat
    IngredBook["pork"] = FoodType.Meat
    IngredBook["peperoni"] = FoodType.Meat
    IngredBook["chicken leg"] = FoodType.Meat
    IngredBook["ground pork"] = FoodType.Meat
    IngredBook["chorizo"] = FoodType.Meat
    IngredBook["chicken wings"] = FoodType.Meat
    IngredBook["beef roast"] = FoodType.Meat
    IngredBook["salami"] = FoodType.Meat
    IngredBook["pork roast"] = FoodType.Meat
    IngredBook["ground chicekn"] = FoodType.Meat
    IngredBook["pork ribs"] = FoodType.Meat
    IngredBook["spam"] = FoodType.Meat
    IngredBook["bologna"] = FoodType.Meat
    IngredBook["lamb"] = FoodType.Meat
    IngredBook["corned beef"] = FoodType.Meat
    IngredBook["chicken roast"] = FoodType.Meat
    IngredBook["duck"] = FoodType.Meat
    IngredBook["pork belly"] = FoodType.Meat
    IngredBook["pastrami"] = FoodType.Meat
    IngredBook["chicken tenders"] = FoodType.Meat
    
    IngredBook["canned tuna"] = FoodType.Seafood
    IngredBook["salmon"] = FoodType.Seafood
    IngredBook["fish fillets"] = FoodType.Seafood
    IngredBook["canned salmon"] = FoodType.Seafood
    IngredBook["smoked salmon"] = FoodType.Seafood
    IngredBook["tuna steak"] = FoodType.Seafood
    IngredBook["whitefish"] = FoodType.Seafood
    IngredBook["halibut"] = FoodType.Seafood
    IngredBook["trout"] = FoodType.Seafood
    IngredBook["haddock"] = FoodType.Seafood
    IngredBook["flounder"] = FoodType.Seafood
    IngredBook["catfish"] = FoodType.Seafood
    IngredBook["caviar"] = FoodType.Seafood
    IngredBook["eel"] = FoodType.Seafood
    IngredBook["bluefish"] = FoodType.Seafood
    IngredBook["carp"] = FoodType.Seafood
    IngredBook["shrimp"] = FoodType.Seafood
    IngredBook["crab"] = FoodType.Seafood
    IngredBook["prawns"] = FoodType.Seafood
    IngredBook["scallop"] = FoodType.Seafood
    IngredBook["clam"] = FoodType.Seafood
    IngredBook["lobster"] = FoodType.Seafood
    IngredBook["mussel"] = FoodType.Seafood
    IngredBook["oyster"] = FoodType.Seafood
    IngredBook["squid"] = FoodType.Seafood
    IngredBook["calamari"] = FoodType.Seafood
    IngredBook["crafish"] = FoodType.Seafood
    IngredBook["octopus"] = FoodType.Seafood
    
    IngredBook["mayonnaise"] = FoodType.Seasonings
    IngredBook["ketchup"] = FoodType.Seasonings
    IngredBook["mustard"] = FoodType.Seasonings
    IngredBook["vinegar"] = FoodType.Seasonings
    IngredBook["soy sauce"] = FoodType.Seasonings
    IngredBook["balsamic vinegar"] = FoodType.Seasonings
    IngredBook["worcestershire"] = FoodType.Seasonings
    IngredBook["hot sauce"] = FoodType.Seasonings
    IngredBook["barbecue sauce"] = FoodType.Seasonings
    IngredBook["ranch dressing"] = FoodType.Seasonings
    IngredBook["wine vinegar"] = FoodType.Seasonings
    IngredBook["apple cider vinegar"] = FoodType.Seasonings
    IngredBook["cider vinegar"] = FoodType.Seasonings
    IngredBook["italian dressing"] = FoodType.Seasonings
    IngredBook["rice vinegar"] = FoodType.Seasonings
    IngredBook["tabasco"] = FoodType.Seasonings
    IngredBook["fish sauce"] = FoodType.Seasonings
    IngredBook["teriyaki"] = FoodType.Seasonings
    IngredBook["steak sauce"] = FoodType.Seasonings
    IngredBook["tahini"] = FoodType.Seasonings
    IngredBook["enchilada sauce"] = FoodType.Seasonings
    IngredBook["oyster sauce"] = FoodType.Seasonings
    IngredBook["honey mustard"] = FoodType.Seasonings
    IngredBook["sriracha"] = FoodType.Seasonings
    IngredBook["caesar dressing"] = FoodType.Seasonings
    IngredBook["taco sauce"] = FoodType.Seasonings
    IngredBook["mirin"] = FoodType.Seasonings
    IngredBook["blue cheese dressing"] = FoodType.Seasonings
    IngredBook["buffalo sauce"] = FoodType.Seasonings
    IngredBook["french dressing"] = FoodType.Seasonings
    IngredBook["sesame dressing"] = FoodType.Seasonings
    IngredBook["ground ginger"] = FoodType.Seasonings
    IngredBook["sesame seed"] = FoodType.Seasonings
    IngredBook["chili sauce"] = FoodType.Seasonings
    IngredBook["rice wine"] = FoodType.Seasonings
    IngredBook["poppy seed"] = FoodType.Seasonings
    IngredBook["balsamic glaze"] = FoodType.Seasonings
    IngredBook["miso"] = FoodType.Seasonings
    IngredBook["wasabi"] = FoodType.Seasonings
    IngredBook["rose water"] = FoodType.Seasonings
    IngredBook["mustard powder"] = FoodType.Seasonings
    IngredBook["mango powder"] = FoodType.Seasonings
    IngredBook["matcha powder"] = FoodType.Seasonings
    IngredBook["tomato sauce"] = FoodType.Seasonings
    IngredBook["tomato paste"] = FoodType.Seasonings
    IngredBook["salsa"] = FoodType.Seasonings
    IngredBook["pesto"] = FoodType.Seasonings
    IngredBook["alfredo sauce"] = FoodType.Seasonings
    IngredBook["beef gravy"] = FoodType.Seasonings
    IngredBook["curry paste"] = FoodType.Seasonings
    IngredBook["chicken gravy"] = FoodType.Seasonings
    IngredBook["cranberry sauce"] = FoodType.Seasonings
    IngredBook["turkey gravy"] = FoodType.Seasonings
    IngredBook["mushroom gravy"] = FoodType.Seasonings
    IngredBook["sausage gravy"] = FoodType.Seasonings
    IngredBook["onion gravy"] = FoodType.Seasonings
    IngredBook["cream gravy"] = FoodType.Seasonings
    IngredBook["tomato gravy"] = FoodType.Seasonings
    
    IngredBook["olive oil"] = FoodType.Oils
    IngredBook["vegetable oil"] = FoodType.Oils
    IngredBook["cooking spray"] = FoodType.Oils
    IngredBook["canola oil"] = FoodType.Oils
    IngredBook["sesame oil"] = FoodType.Oils
    IngredBook["coconut oil"] = FoodType.Oils
    IngredBook["peanut oil"] = FoodType.Oils
    IngredBook["sunflower oil"] = FoodType.Oils
    IngredBook["grape seed oil"] = FoodType.Oils
    IngredBook["corn oil"] = FoodType.Oils
    IngredBook["almond oil"] = FoodType.Oils
    IngredBook["avocado oil"] = FoodType.Oils
    IngredBook["safflower oil"] = FoodType.Oils
    IngredBook["walnut oil"] = FoodType.Oils
    IngredBook["hazelnut oil"] = FoodType.Oils
    IngredBook["palm oil"] = FoodType.Oils
    IngredBook["soybean oil"] = FoodType.Oils
    IngredBook["mustard oil"] = FoodType.Oils
    IngredBook["pistachio oil"] = FoodType.Oils
    
    IngredBook["green beans"] = FoodType.Legume
    IngredBook["black beans"] = FoodType.Legume
    IngredBook["peas"] = FoodType.Legume
    IngredBook["chickpea"] = FoodType.Legume
    IngredBook["lentil"] = FoodType.Legume
    IngredBook["refried beans"] = FoodType.Legume
    IngredBook["chili beans"] = FoodType.Legume
    IngredBook["hummus"] = FoodType.Legume
    IngredBook["kidney beans"] = FoodType.Legume
    IngredBook["pinto beans"] = FoodType.Legume
    IngredBook["edamame"] = FoodType.Legume
    IngredBook["split beans"] = FoodType.Legume
    IngredBook["snap beans"] = FoodType.Legume
    IngredBook["soybeans"] = FoodType.Legume
    
    IngredBook["chicken broth"] = FoodType.Soup
    IngredBook["mushroom soup"] = FoodType.Soup
    IngredBook["beef broth"] = FoodType.Soup
    IngredBook["tomato soup"] = FoodType.Soup
    IngredBook["chicken soup"] = FoodType.Soup
    IngredBook["onion soup"] = FoodType.Soup
    IngredBook["vegetable soup"] = FoodType.Soup
    
    IngredBook["peanut butter"] = FoodType.Nut
    IngredBook["almond"] = FoodType.Nut
    IngredBook["walnut"] = FoodType.Nut
    IngredBook["pecan"] = FoodType.Nut
    IngredBook["peanut"] = FoodType.Nut
    IngredBook["cashew"] = FoodType.Nut
    IngredBook["flax"] = FoodType.Nut
    IngredBook["pistachio"] = FoodType.Nut
    IngredBook["pine nut"] = FoodType.Nut
    IngredBook["hazelnut"] = FoodType.Nut
    IngredBook["macademia"] = FoodType.Nut
    
    IngredBook["white wine"] = FoodType.Beverages
    IngredBook["red wine"] = FoodType.Beverages
    IngredBook["beer"] = FoodType.Beverages
    IngredBook["vodka"] = FoodType.Beverages
    IngredBook["rum"] = FoodType.Beverages
    IngredBook["tequila"] = FoodType.Beverages
    IngredBook["whiskey"] = FoodType.Beverages
    IngredBook["bourbon"] = FoodType.Beverages
    IngredBook["cooking wine"] = FoodType.Beverages
    IngredBook["whisky"] = FoodType.Beverages
    IngredBook["coffee"] = FoodType.Beverages
    IngredBook["orange juice"] = FoodType.Beverages
    IngredBook["tea"] = FoodType.Beverages
    IngredBook["apple juice"] = FoodType.Beverages
    IngredBook["tomato juice"] = FoodType.Beverages
    IngredBook["espresso"] = FoodType.Beverages
    IngredBook["fruit juice"] = FoodType.Beverages
    
    IngredBook["coconut milk"] = FoodType.DairyAlt
    IngredBook["almond milk"] = FoodType.DairyAlt
    IngredBook["soy milk"] = FoodType.DairyAlt
    IngredBook["rice milk"] = FoodType.DairyAlt
    IngredBook["non dairy creamer"] = FoodType.DairyAlt
    
}


var myRecipe = [Int]() // stores index of recipe book
class PotRecipeType{
    var index : Int
    var ingredList: [Ingrd] = []
    
    init (index_in: Int, ingredList_in: [Ingrd]){
        index = index_in
        ingredList = ingredList_in
    }
    
}
var potentialRecipe = [PotRecipeType]() // stores index of recipe book
// generate recipe when ingredient is added
func generateRecipe(){
    for (index,recipe) in RecipeBook.enumerated() { // for each recipe
        
        var found : Bool = false
        // if the recipe already exists in myRcipe, then skip
        for i in myRecipe{
            if index == i{
                found = true
                break // exit the smaller loop
            }
        }
        if(found){
            continue // continue to look for next recipe
        }
        
        let Set_all = Set(arrayLiteral: recipe.DairyList, recipe.FruitsList, recipe.VeggieList, recipe.BakedNGrainsList, recipe.SeasoningsList,  recipe.MeatList, recipe.SeafoodList, recipe.LegumeList, recipe.NutList, recipe.OilsList, recipe.SoupList, recipe.DairyAltList, recipe.BeveragesList)
        
        var IngredList : Set<Ingrd> = []
        for it in Set_all{
            IngredList = IngredList.union(it)
        }
        
        for ingred in myFridge{ // compare with the ingredients in user's fridge
            
            if ingred.Ingrd_Type == FoodType.Dairy {
                if !recipe.DairyList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.DairyList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.Fruits{
                if !recipe.FruitsList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.FruitsList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.Veggie{
                if !recipe.VeggieList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.VeggieList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.BakedNGrains{
                if !recipe.BakedNGrainsList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.BakedNGrainsList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.Seasonings{
                if !recipe.SeasoningsList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.SeasoningsList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.Meat{
                if !recipe.MeatList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.MeatList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.Seafood{
                if !recipe.SeafoodList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.SeafoodList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.Legume{
                if !recipe.LegumeList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.LegumeList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.Nut{
                if !recipe.NutList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.NutList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.Oils{
                if !recipe.OilsList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.OilsList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.Soup{
                if !recipe.SoupList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.SoupList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.DairyAlt{
                if !recipe.DairyAltList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.DairyAltList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
            else if ingred.Ingrd_Type == FoodType.Beverages{
                if !recipe.BeveragesList.isEmpty{ // if the list is not empty
                    // find in the list
                    if (recipe.BeveragesList.contains(ingred)){
                        // found the ingredient
                        IngredList.remove(ingred)
                    }
                }
            }
        }
        
        
        if (IngredList.count < 0){
            print("error on counting tot_count")
        }
        else if (IngredList.count == 0){
            myRecipe.append(index)
        }
        else if (IngredList.count < 3){
            potentialRecipe.append(PotRecipeType(index_in: index, ingredList_in: Array(IngredList)))
            // potential recipe
        }
    }
}


var availRecipe = [Int]() // Stores recipe index that user can make
struct RecipeBookInfo{
    
    var FoodName : String
    
    // List of Food Types
    var DairyList = Set<Ingrd>()
    var FruitsList = Set<Ingrd>()
    var VeggieList = Set<Ingrd>()
    var BakedNGrainsList = Set<Ingrd>()
    var SeasoningsList = Set<Ingrd>()
    var MeatList = Set<Ingrd>()
    var SeafoodList = Set<Ingrd>()
    var LegumeList = Set<Ingrd>()
    var NutList = Set<Ingrd>()
    var OilsList = Set<Ingrd>()
    var SoupList = Set<Ingrd>()
    var DairyAltList = Set<Ingrd>()
    var BeveragesList = Set<Ingrd>()
    
    var Steps : String
    
    init (name_in: String, array_in: [Ingrd], steps_in: String) {
        
        FoodName = name_in
        Steps = steps_in
        
        for ingred_in in array_in{
            if(ingred_in.Ingrd_Type == FoodType.Dairy){
                DairyList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Fruits){
                FruitsList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Veggie){
                VeggieList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.BakedNGrains){
                BakedNGrainsList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Seasonings){
                LegumeList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Meat){
                MeatList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Seafood){
                SeafoodList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Legume){
                LegumeList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Nut){
                NutList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Oils){
                OilsList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Soup){
                SoupList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.DairyAlt){
                DairyAltList.insert(ingred_in)
            }
            else if(ingred_in.Ingrd_Type == FoodType.Beverages){
                BeveragesList.insert(ingred_in)
            }
        }
    } // Initilizer
}

var RecipeBook = [RecipeBookInfo]() // Recipe Book :D
func initRecipeBook(){
    // banana milk
    let IngrdArray = [Ingrd(name_in: "banana"), Ingrd(name_in: "milk".lowercased())]
    RecipeBook.append(RecipeBookInfo(name_in: "Banana Smoothie", array_in: IngrdArray, steps_in: "Blend Banana and Milk"))
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
        setCardView(view: viewCell)
        viewCell.backgroundColor = UIColor("FFAF87")
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
        let cat = convertType(ing_in: categoryTextField.text!)
        let input_ingred = Ingrd(name_in: input, type_in: cat)
        // MARK: ^^ no need
        
        // make set and search for the item
        let myFridgeSet = Set<Ingrd>(myFridge)
        let ingred_in = Ingrd(name_in: input)
        // if it's not already in myFridge, add to myFridge
        if(!myFridgeSet.contains(ingred_in)){
            myFridge.append(ingred_in)
        }
        // update potential Recipe
        
        
        // when ingredient is added
        // go thru potential recipe list
        // if the recipe has the ingredient
        // if the count is 1
        // then remove it and append it to myRecipe
        // else
        // remove it from the list
        
        // array to keep track of index of potentialRecipe to delete
        var arr = [Int]()
        for (i, PRType) in potentialRecipe.enumerated(){
            if PRType.ingredList.contains(ingred_in){
                if PRType.ingredList.capacity == 1{
                    arr.append(i)
                    myRecipe.append(PRType.index)
                }
                else{
                    var ing_index = -1
                    // find the index of the ingredient on the ingredList
                    for (i,ing) in PRType.ingredList.enumerated(){
                        if ing == ingred_in{
                            ing_index = i
                        }
                    }
                    // remove it
                    
                    
                    if ing_index == -1{
                        print("invalid ing_index")
                    }
                    else{
                        PRType.ingredList.remove(at: ing_index)
                    }
                    
                }
            }
        }
        
        arr.sort()
        arr.reverse()
        for i in arr{
            potentialRecipe.remove(at: i)
        }
        
        
<<<<<<< HEAD
        let banner = Banner(title: "Success!", subtitle: "Added " + nameTextField.text! + " to ingredients list.", image: UIImage(named: "Icon"), backgroundColor: UIColor("#31CC97")!)
=======
         let banner = Banner(title: "Success!", subtitle: "Added " + nameTextField.text! + " to ingredients list.", image: UIImage(named: "Icon"), backgroundColor: UIColor("#31CC97")!)
>>>>>>> 3786f678237f0c061944ed62db2ce437a03d3e9f
        banner.dismissesOnTap = true
        banner.show(duration: 3.0)
        
        
        // update availRecipe
        generateRecipe()
        
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
        
        var ingredDropDown = [String]()
        for (key, value) in IngredBook{
            ingredDropDown.append(key)
        }
        nameTextField.filterStrings(ingredDropDown)
    }
    
}

func convertType(ing_in: String) -> FoodType {
    if(ing_in == "Dairy") {
        return FoodType.Dairy
    }
    else if(ing_in == "Fruits") {
        return FoodType.Fruits
    }
    else if(ing_in == "Vegetables") {
        return FoodType.Veggie
    }
    else if(ing_in == "Baked Goods & Grains") {
        return FoodType.BakedNGrains
    }
    else if(ing_in == "Seasonings") {
        return FoodType.Seasonings
    }
    else if(ing_in == "Legume") {
        return FoodType.Legume
    }
    else if(ing_in == "Meat"){
        return FoodType.Meat
    }
    else if(ing_in == "Seafood"){
        return FoodType.Seafood
    }
    else if(ing_in == "Nut"){
        return FoodType.Nut
    }
    else if(ing_in == "Oils"){
        return FoodType.Oils
    }
    else if(ing_in == "Soup"){
        return FoodType.Soup
    }
    else if(ing_in == "Dairy Alternatives"){
        return FoodType.DairyAlt
    }
    else if(ing_in == "Bevereages"){
        return FoodType.Beverages
    }
    print("error in converttype")
    return FoodType.Beverages
}

func FTtoSTRING(ing_in: FoodType) -> String {
    if(ing_in == FoodType.Dairy) {
        return "Dairy"
    }
    else if(ing_in == FoodType.Fruits) {
        return "Fruits"
    }
    else if(ing_in == FoodType.Veggie) {
        return "Vegetables"
    }
    else if(ing_in == FoodType.BakedNGrains) {
        return "Baked Goods & Grains"
    }
    else if(ing_in == FoodType.Seasonings) {
        return "Seasonings"
    }
    else if(ing_in == FoodType.Legume) {
        return "Legume"
    }
    else if(ing_in == FoodType.Meat) {
        return "Meat"
    }
    else if(ing_in == FoodType.Seafood) {
        return "Seafood"
    }
    else if(ing_in == FoodType.Nut) {
        return "Nut"
    }
    else if(ing_in == FoodType.Oils) {
        return "Oils"
    }
    else if(ing_in == FoodType.Soup) {
        return "Soup"
    }
    else if(ing_in == FoodType.DairyAlt) {
        return "Dairy Alternatives"
    }
    else if(ing_in == FoodType.Beverages) {
        return "Beverages"
    }
    print("error in FTtostring")
    return "Beverages"
}
