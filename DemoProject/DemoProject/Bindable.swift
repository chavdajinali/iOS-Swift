//
//  Bindable.swift
//  DemoProject
//
//  Created by Belocum28 on 22/03/24.
//  Copyright © 2024 Belocum. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
    
}
