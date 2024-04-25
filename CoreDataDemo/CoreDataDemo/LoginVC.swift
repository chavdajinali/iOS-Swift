//
//  LoginVC.swift
//  CoreDataDemo
//
//  Created by BeLocum-6 on 09/04/24.
//

import UIKit
import Combine

class LoginVC: UIViewController,Storyboardable {
    
    static let storyboardname: StoryboardName = .Main

    
    //MARK: - Outlets
     
    @IBOutlet weak var txtUserEmail:UITextField!
    @IBOutlet weak var txtPassword:UITextField!
    
    @IBOutlet weak var lblErrorMessage:UILabel!
    
    @IBOutlet weak var btnLogin:UIButton!
    
    @IBOutlet weak var btnRegister:UIButton!
    
    var viewModel = LoginModel()
    var cancellables = Set<AnyCancellable>()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.titleView?.isHidden = true
        setupPublishersLogin()
    }
    
    //MARK: - Functions
    
    func setupPublishersLogin() {
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: txtUserEmail)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.emailData, on: viewModel)
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: txtPassword)
            .receive(on: RunLoop.main)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.passwordData, on: self.viewModel)
            .store(in: &cancellables)
            
        
        viewModel.$state
            .sink { [weak self] state in
                switch state {
                    case .loading:
                        self?.btnLogin.isEnabled = false
                        self?.hideError(true)
                    case .success:
                        self?.showResultScreen()
                        self?.hideError(true)
                    case .failed:
                        self?.hideError(false)
                    case .none:
                        break
                }
            }
            .store(in: &cancellables)
        
    }
    
    func showResultScreen() {
        
        let alertController = UIAlertController(title: "Core Data", message: "Login Completed Sucessfully.", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            let vc = HomeVC.storyboardViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)

    }
    
    func hideError(_ isHidden: Bool) {
        btnLogin.isEnabled = true
        lblErrorMessage.isHidden = isHidden
        lblErrorMessage.text = "Please enter valid credential."
        viewModel.$errorMessage
            .sink { data in
                if !data.isEmpty {
                    self.lblErrorMessage.text = data
                }
        }
    }
    
    //MARK:  - Actions
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        viewModel.fetchData()
    }
    
    @IBAction func btnRegister_Clicked(_ sender: UIButton) {
        let vc = RegistrationVC.storyboardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

