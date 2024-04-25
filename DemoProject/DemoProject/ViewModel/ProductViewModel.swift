//
//  ProductViewModel.swift
//  DemoProject
//
//  Created by BeLocum-6 on 23/04/24.
//  Copyright © 2024 Belocum. All rights reserved.
//

import Foundation

//Presenter Protocol Method to UpdateUI
//protocol PresenterProtocol {
//    func onGetProducts()
//    func onGetProductsError(error:String)
//}

class ProductViewModel {
    
    var productProtocol: ProductProtocol?
    //delegate
//    var delegatePresentProtocol:PresenterProtocol?
    
    var products = Bindable<[Products]>()
    var errorData = Bindable<String>()
    
    init(productProtocol: ProductProtocol? = nil) {
        self.productProtocol = productProtocol
    }
    
    func getProductsFromAPICall() {
        productProtocol?.getProducts( success: { [weak self] productsResponse in
            self?.products.value = productsResponse.products
            //Delegate passdata
//            self?.delegatePresentProtocol?.onGetProducts()
            
        }, fail: { [weak self] errorDataResponse in
            self?.errorData.value = errorDataResponse?.localizedDescription
            //delegate passdata
//            self?.delegatePresentProtocol?.onGetProductsError(error: errorDataResponse?.localizedDescription ?? "")
        })
    }
}
