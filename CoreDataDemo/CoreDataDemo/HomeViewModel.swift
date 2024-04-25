//
//  HomeViewModel.swift
//  CoreDataDemo
//
//  Created by BeLocum-6 on 10/04/24.
//

import Foundation
import CoreData

class HomeViewModel : ObservableObject {
    
    func fetchData () {
        
        var Users  = [User]()
        
        let managedContext = CoreDataManger().persistentManger.viewContext
        
        let fetchRequest  = NSFetchRequest<User>(entityName: "User")
                
        do {
            
            let Users = try managedContext.fetch(fetchRequest) as [User]
            if !Users.isEmpty {
                for user in Users {
                    print(user.username ?? "")
                }
            }else {
                
            }
        } catch {
            
        }
    }
    
}
