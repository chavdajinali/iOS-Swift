//
//  RegistrationVC.swift
//  CoreDataDemo
//
//  Created by BeLocum-6 on 09/04/24.
//

import UIKit
import CoreData
import Combine

class RegistrationVC: UIViewController,Storyboardable {
    
    static let storyboardname: StoryboardName = .Main

    @IBOutlet weak var stackViewRegistration:UIStackView!
    @IBOutlet weak var txtName:UITextField!
    @IBOutlet weak var txtDesignation:UITextField!
    @IBOutlet weak var txtPhone:UITextField!
    @IBOutlet weak var txtEmail:UITextField!
    @IBOutlet weak var txtAddress:UITextField!
    @IBOutlet weak var txtPassword:UITextField!
    
    @IBOutlet weak var lblErrorlabel:UILabel!
    
    @IBOutlet weak var btnRegistration:UIButton!
    
    var viewModel = RegistrationModel()
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPublishers()
        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK: - Actions
    
    @IBAction func btnRegistration_Cliked(_sender:UIButton) {
        setupPublishers()
        onSubmit()
    }
    
    //MARK: - Functions
    
    func setupPublishers() {
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: txtEmail)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.emailData, on: viewModel)
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: txtPassword)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.passwordData, on: viewModel)
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: txtName)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.nameData, on: viewModel)
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: txtPhone)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.phoneData, on: viewModel)
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: txtDesignation)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.designationData , on: viewModel)
            .store(in: &cancellables)
        
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: txtAddress)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.addressData , on: viewModel)
            .store(in: &cancellables)
        
        viewModel.$state
            .sink { [weak self] state in
                switch state {
                    case .loading:
                        self?.btnRegistration.isEnabled = false
                        self?.btnRegistration.setTitle("Loading..", for: .normal)
                        self?.hideError(true)
                    case .success:
                        self?.showResultScreen()
                        self?.resetButton()
                        self?.hideError(true)
                    case .failed:
                        self?.resetButton()
                        self?.hideError(false)
                    case .none:
                        break
                }
            }
            .store(in: &cancellables)
        
    }
    
    @objc func onSubmit() {
        
        viewModel.submitRegistration()
    }

    func showResultScreen() {
        
        let alertController = UIAlertController(title: "Core Data", message: "Registration Completed Sucessfully.", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            let vc = LoginVC.storyboardViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)

    }
    
    func resetButton() {
        btnRegistration.setTitle("Registration", for: .normal)
        btnRegistration.isEnabled = false
        if lblErrorlabel.text == "You alrready register here please login."{
            let vc = LoginVC.storyboardViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func hideError(_ isHidden: Bool) {
        lblErrorlabel.text = "data is not correct"
        viewModel.$errorMessage
            .sink { data in
            self.lblErrorlabel.text = data
        }
        lblErrorlabel.isHidden = isHidden
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(20)) { [weak self] in
            self?.resetButton()
        }
    }
   
}

