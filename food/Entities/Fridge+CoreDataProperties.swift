//
//  Fridge+CoreDataProperties.swift
//  
//
//  Created by Sabina Kim on 8/5/18.
//
//

import Foundation
import CoreData


extension Fridge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fridge> {
        return NSFetchRequest<Fridge>(entityName: "Fridge")
    }

    @NSManaged public var ingredients: NSSet?

}

// MARK: Generated accessors for ingredients
extension Fridge {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: Ingred)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: Ingred)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}
