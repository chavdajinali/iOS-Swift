//
//  HomeVC.swift
//  CoreDataDemo
//
//  Created by BeLocum-6 on 10/04/24.
//

import UIKit

class HomeVC: UIViewController,Storyboardable {
    
    static let storyboardname: StoryboardName = .Home

    @IBOutlet weak var imgNoDat: UIImageView!
    @IBOutlet weak var tblShowAllData: UITableView!
    @IBOutlet weak var btnFetchAllData: UIButton!
    
    var userList = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.titleView?.isHidden = true
        
        if userList.isEmpty {
            imgNoDat.isHidden = false
        }else{
            imgNoDat.isHidden = true
        }
        
    }
    
    @IBAction func btnFetchAllData_Clicked(_ sender: UIButton) {
        
    }
    
}
