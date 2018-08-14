//
//  MyRecipe+CoreDataProperties.swift
//  
//
//  Created by Sabina Kim on 8/5/18.
//
//

import Foundation
import CoreData


extension MyRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyRecipe> {
        return NSFetchRequest<MyRecipe>(entityName: "MyRecipe")
    }

    @NSManaged public var isFav: Bool
    @NSManaged public var isShoppingList: Bool
    @NSManaged public var recipeBook: NSSet?

}

// MARK: Generated accessors for recipeBook
extension MyRecipe {

    @objc(addRecipeBookObject:)
    @NSManaged public func addToRecipeBook(_ value: RecipeBook)

    @objc(removeRecipeBookObject:)
    @NSManaged public func removeFromRecipeBook(_ value: RecipeBook)

    @objc(addRecipeBook:)
    @NSManaged public func addToRecipeBook(_ values: NSSet)

    @objc(removeRecipeBook:)
    @NSManaged public func removeFromRecipeBook(_ values: NSSet)

}
