//
//  LoginModel.swift
//  CoreDataDemo
//
//  Created by BeLocum-6 on 10/04/24.
//

import Foundation
import UIKit
import CoreData
import Combine

class LoginModel:ObservableObject {
    
    static let storyboardname: StoryboardName = .Main
    
    @Published var emailData = ""
    @Published var passwordData = ""
    
    @Published var state: ViewState = .none
    @Published var errorMessage = ""
    

    var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $emailData
            .map {
                 $0.isValidEmail
            }
            .eraseToAnyPublisher()
    }

    var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $passwordData
            .map { $0.isValidPassword }
            .eraseToAnyPublisher()
    }
    
    func fetchData() {
        self.state = .loading
        
        let managedContext = CoreDataManger().persistentManger.viewContext
        
        let fetchRequest  = NSFetchRequest<User>(entityName: "User")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "email == %@ && password == %@", "\(emailData)","\(passwordData)")
        
        do { 
            let result = try managedContext.fetch(fetchRequest)
            
            if !result.isEmpty {
                print("login successfully.")
                UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
                self.state = .success
            }else{
                print("Please enter valid credential.")
                self.errorMessage = "Please enter valid credential."
                self.state = .failed
            }
            
        } catch {
            self.errorMessage = "Something went wrong."
            self.state = .failed
            return
        }
    }
}
