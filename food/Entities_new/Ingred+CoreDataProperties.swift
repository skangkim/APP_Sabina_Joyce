//
//  Ingred+CoreDataProperties.swift
//  food
//
//  Created by Sabina Kim on 8/6/18.
//  Copyright © 2018 J Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension Ingred {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingred> {
        return NSFetchRequest<Ingred>(entityName: "Ingred")
    }
    @objc public enum FoodType: Int32{
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
    
    @NSManaged public var foodType: Int32
    @NSManaged public var inFridge: Bool
    @NSManaged public var name: String
    @NSManaged public var ingredInfo: IngredInfo?
    @NSManaged public var potRecipe: PotRecipe?
    

}
