//
//  Storyboardable.swift
//  CoreDataDemo
//
//  Created by BeLocum-6 on 10/04/24.
//

import Foundation
import UIKit

protocol Storyboardable {
    static var storyboardname: StoryboardName { get }
    static func storyboardViewController() -> Self

}

extension Storyboardable where Self: UIViewController {
    
    static var storyboardName: String {
        return String(describing: storyboardname.rawValue)
    }
    
    static func storyboardViewController() -> Self {
        guard let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as? Self else {
            fatalError("Unable to Instantiate View Controller With Storyboard Identifier \(storyboardName)")
        }
        return viewController
    }
}

enum StoryboardName: String {
    case Main
    case Home
}
