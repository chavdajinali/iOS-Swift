//
//  ViewRepository.swift
//  DemoProject
//
//  Created by Belocum28 on 22/03/24.
//  Copyright © 2024 Belocum. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    var inputOne: Int { get set }
    var inputTwo: Int { get }
    func addition(_ first: Int, second: Int) -> Int
}

protocol ViewModelProtocolTwo {
    func substraction(_ first: Int, second: Int) -> Int
    
}

class ViewModelRepository: ViewModelProtocol, ViewModelProtocolTwo {
    var inputOne: Int = 0
    var inputTwo: Int = 0
    
    func substraction(_ first: Int, second: Int) -> Int {
        return first - second
    }
    
    
    func addition(_ first: Int, second: Int) -> Int {
        return first + second
    }
}
