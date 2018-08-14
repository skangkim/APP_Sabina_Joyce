//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Sabina Kim on 8/5/18.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "PotRecipe")
    }

    @NSManaged public var potIngreds: NSSet?
    @NSManaged public var recipeBook: RecipeBook?

}

// MARK: Generated accessors for potIngreds
extension Entity {

    @objc(addPotIngredsObject:)
    @NSManaged public func addToPotIngreds(_ value: Ingred)

    @objc(removePotIngredsObject:)
    @NSManaged public func removeFromPotIngreds(_ value: Ingred)

    @objc(addPotIngreds:)
    @NSManaged public func addToPotIngreds(_ values: NSSet)

    @objc(removePotIngreds:)
    @NSManaged public func removeFromPotIngreds(_ values: NSSet)

}
