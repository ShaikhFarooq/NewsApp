//
//  DataStoreManager.swift
//  NewsApp
//
//  Created by Admin on 9/16/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import Foundation
import CoreData


class DatastoreManager {
    
    public static var shared: DatastoreManager? = nil
    private static let entityName = "Headlines"
    
    var managedContext: NSManagedObjectContext
    var persistentContainer: NSPersistentContainer?
    
    private init(context: NSManagedObjectContext) {
        self.managedContext = context
    }
    
    public class func shared(context: NSManagedObjectContext) {
        if (self.shared == nil) {
            self.shared = DatastoreManager(context: context)
            self.shared!.managedContext = context
        }
    }
    
    public func saveHeadline(title: String, description: String,author: String,date: String,poster: String) {
        // Create Entity
        let entity = NSEntityDescription.entity(forEntityName: DatastoreManager.entityName, in: managedContext)
        
        // Initialize Record
        let headline = Headlines(entity: entity!, insertInto: managedContext)
        headline.title = title
        headline.descrip = description
        headline.author = author
        headline.date = date
        headline.poster = poster
        
        managedContext.performAndWait {
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("could not save, managedobject \(error), \(error.userInfo)")
            }
        }
    }

    
    public func fetchAllSavedHeadlines() -> [Headlines] {
        let request: NSFetchRequest<Headlines> = Headlines.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            return result
        } catch {
            print("fetch request failed, managedobject")
            return [Headlines]()
        }
    }
    
    public func deleteAllSavedHeadlines() {
        let savedItems = fetchAllSavedHeadlines()
        for savedItem in savedItems {
            managedContext.performAndWait {
                managedContext.delete(savedItem)
            }
        }
    }
}

