//
//  IngredInfo+CoreDataProperties.swift
//  food
//
//  Created by Sabina Kim on 8/6/18.
//  Copyright © 2018 J Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension IngredInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IngredInfo> {
        return NSFetchRequest<IngredInfo>(entityName: "IngredInfo")
    }
    @objc public enum Unit: Int32{
        case lb
        case oz
        case count
    }
    
    
    @NSManaged public var isSL: Bool
    @NSManaged public var unit: Unit
    @NSManaged public var quantity: Double
    @NSManaged public var ingredients: Ingred
    @NSManaged public var recipe: Recipe

}
