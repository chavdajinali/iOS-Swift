//
//  Storyboardable.swift
//  DemoProject
//
//  Created by Belocum28 on 08/04/24.
//  Copyright © 2024 Belocum. All rights reserved.
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
