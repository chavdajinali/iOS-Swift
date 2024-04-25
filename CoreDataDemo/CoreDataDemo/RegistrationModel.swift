//
//  RegistrationModel.swift
//  CoreDataDemo
//
//  Created by BeLocum-6 on 10/04/24.
//

import Foundation
import Combine
import UIKit
import CoreData

enum ViewState {
    case loading
    case success
    case failed
    case none
}

class RegistrationModel: ObservableObject {
    
    @Published var nameData = ""
    @Published var phoneData = ""
    @Published var designationData = ""
    @Published var addressData = ""
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
    
    var isValidnamePublisher: AnyPublisher<Bool,Never> {
        $nameData
            .map{
                return !$0.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    var isValidAddressPublisher: AnyPublisher<Bool,Never> {
        $addressData
            .map{ 
                return  !$0.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    var isValidDesignationPublisher: AnyPublisher<Bool,Never> {
        $designationData
            .map{ !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isValidPhonePublisher: AnyPublisher<Bool,Never> {
        $phoneData
            .map{ $0.isValidPhone }
            .eraseToAnyPublisher()
    }
    
    var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $passwordData
            .map { $0.isValidPassword }
            .eraseToAnyPublisher()
    }
    
    
    func submitRegistration() {

        state = .loading
        // hardcoded 2 seconds delay, to simulate request
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let self = self else { return }
            let data = self.isCorrectRegistration()
            if data.0 {
                self.state = .success
            } else {
                self.errorMessage = data.1
                self.state = .failed
            }
        }
    }
    
    func isCorrectRegistration() -> (Bool,String) {
        
        
        let managedContext = CoreDataManger().persistentManger.viewContext
        
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        fetchRequest.predicate = NSPredicate(format: "email LIKE %@", "\(_emailData)")
        
        do {
            
            let result = try managedContext.fetch(fetchRequest)
            if !result.isEmpty {
                for data in result as! [NSManagedObject] {
                    print(data.value(forKey: "email") as? String ?? "")
                    if data.value(forKey: "email") as? String ?? "" == "" {
                        let data = createRecord()
                        if data.0 {
                            return (true,"Data added Successfully")
                        }else{
                            return (false,data.1)
                        }
                    }else{
                        return (false,"You alrready register here please login.")
                    }
                }

            }else {
                let data = createRecord()
                if (data.0) {
                    return (true,"Data added Successfully")
                }else{
                    return (false,data.1)
                }
            }
            return (false,"Something went wrong")
        } catch {
            return (false,"got error")
        }
    }
    
    
    func createRecord() -> (Bool,String){
        
        let managedContext = CoreDataManger().persistentManger.viewContext
        
        let userEnitity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let user = NSManagedObject(entity: userEnitity, insertInto: managedContext)

        do {
            
            let phoneNo = "\(phoneData)"
            user.setValue("\(nameData)", forKey: "username")
            user.setValue("\(emailData)", forKey: "email")
            user.setValue("\(designationData)", forKey: "designation")
            user.setValue("\(addressData)", forKey: "address")
            user.setValue(Int(phoneNo), forKey: "phone")
            user.setValue("\(passwordData)", forKey: "password")
            
            try managedContext.save()
            return (true,"Data added Successfully")
        } catch let error as NSError {
            print("Could Not Save, \(error) , \(error.userInfo)")
            return (false,"Could Not Save, \(error) , \(error.userInfo)")
        }
        
    }
    
}

extension String {
    // 8
    var isValidEmail: Bool {
        return NSPredicate(
            format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        )
        .evaluate(with: self)
    }
    
    var isValidPhone:Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^[0-9+]{0,1}+[0-9]{5,16}$")
            .evaluate(with: self)
    }
    var isValidPassword:Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
}
