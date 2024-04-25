//
//  ViewModel.swift
//  DemoProject
//
//  Created by Belocum28 on 22/03/24.
//  Copyright © 2024 Belocum. All rights reserved.
//

import Foundation


class ViewModel {
    
    deinit {
        print("I am deinit viewmodel")
        print("\(self.result)")

    }
    var protocolOne: ViewModelProtocol?
    var protocolTwo: ViewModelProtocolTwo?
    
    var result = Bindable<Int>()
    
    init(repository: ViewModelRepository) {
        self.protocolOne = repository
        self.protocolTwo = ViewModelRepository()
    }
    
    func additionImplement(_ first: Int, second: Int) {
        result.value = protocolOne?.addition(first, second: second)
        result.value = protocolTwo?.substraction(first, second: second)
    }
}
