//
//  Recipe+CoreDataProperties.swift
//  food
//
//  Created by Sabina Kim on 8/6/18.
//  Copyright © 2018 J Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var name: String
    @NSManaged public var steps: String
    @NSManaged public var isFav: Bool
    @NSManaged public var myRecipe: Bool
    @NSManaged public var ingredients: NSSet
    @NSManaged public var potRecipe: PotRecipe?

}

// MARK: Generated accessors for ingredients
extension Recipe {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: IngredInfo)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: IngredInfo)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}
