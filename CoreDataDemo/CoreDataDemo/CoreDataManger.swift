//
//  CoreDataManger.swift
//  CoreDataDemo
//
//  Created by BeLocum-6 on 10/04/24.
//

import Foundation
import CoreData

internal struct CoreDataManger {
    static let shared = CoreDataManger()
    
    let persistentManger : NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataDemo")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
}
