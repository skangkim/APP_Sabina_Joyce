//
//  PotRecipe+CoreDataProperties.swift
//  food
//
//  Created by Sabina Kim on 8/6/18.
//  Copyright © 2018 J Lee. All rights reserved.
//
//

import Foundation
import CoreData


extension PotRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PotRecipe> {
        return NSFetchRequest<PotRecipe>(entityName: "PotRecipe")
    }

    @NSManaged public var need_Ingred: NSSet?
    @NSManaged public var recipe: Recipe

}

// MARK: Generated accessors for need_Ingred
extension PotRecipe {

    @objc(addNeed_IngredObject:)
    @NSManaged public func addToNeed_Ingred(_ value: Ingred)

    @objc(removeNeed_IngredObject:)
    @NSManaged public func removeFromNeed_Ingred(_ value: Ingred)

    @objc(addNeed_Ingred:)
    @NSManaged public func addToNeed_Ingred(_ values: NSSet)

    @objc(removeNeed_Ingred:)
    @NSManaged public func removeFromNeed_Ingred(_ values: NSSet)

}
