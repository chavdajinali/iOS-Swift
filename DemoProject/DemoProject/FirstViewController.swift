//
//  FirstViewController.swift
//  DemoProject
//
//  Created by Belocum28 on 22/03/24.
//  Copyright © 2024 Belocum. All rights reserved.
//

import Foundation
import UIKit


class FirstViewController: UIViewController, Storyboardable {
    
    
    static let storyboardname: StoryboardName = .Main
    
    @IBOutlet weak  var tblProductList:UITableView!
    
    var productListViewModel: ProductViewModel!
    
    deinit {
        productListViewModel = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        productListViewModel = ProductViewModel(productProtocol: ProductRepository())
        
        //Presenter
//        productListViewModel.delegatePresentProtocol = self
        
        //Bindable object to Update UI
        productListViewModel.products.bind { [weak self] data in
            DispatchQueue.main.async {
                self?.tblProductList.reloadData()
            }
        }
        
        productListViewModel.errorData.bind { errorValue in
            print(errorValue ?? "")
        }
        
        productListViewModel.getProductsFromAPICall()
        
    }
    
   
    
    @IBAction func pushToNewView(_ sender: UIButton) {
        let vc = ViewController.storyboardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FirstViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListViewModel.products.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductListCell
        cell.configuare(productModel: productListViewModel.products.value![indexPath.row])
        return cell
    }
    
}

//Presenter (MVP Structure)
//extension FirstViewController : PresenterProtocol {
//    func onGetProducts() {
//        DispatchQueue.main.async {
//            self.tblProductList.reloadData()
//        }
//    }
//    
//    func onGetProductsError(error: String) {
//        print(error)
//    }
//    
//}
