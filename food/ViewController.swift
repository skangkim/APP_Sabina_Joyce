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
    
    
