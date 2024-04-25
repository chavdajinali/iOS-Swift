//
//  ProductRepository.swift
//  DemoProject
//
//  Created by BeLocum-6 on 23/04/24.
//  Copyright © 2024 Belocum. All rights reserved.
//

import Foundation


protocol ProductProtocol {
    func getProducts(success:@escaping(_ products:ProductMain_Model) -> Void,fail:@escaping(_ errorData:NSError?) -> Void)
}

class ProductRepository :ProductProtocol {
    
    func getProducts(success: @escaping (ProductMain_Model) -> Void, fail: @escaping (NSError?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://dummyjson.com/products")!)) { data, response, error in
            if error == nil {
                do {
                    if let productsData = try JSONDecoder().decode(ProductMain_Model.self, from: data!) as? ProductMain_Model {
                        success(productsData)
                    }else{
                        fail(NSError(domain: "Data Parsing Error!", code: 401))
                    }
                } catch {
                    fail(NSError(domain: "Data Error!", code: 500))
                }
            }else{
                fail(error as NSError?)
            }
        }
        task.resume()
        
    }
    
}
