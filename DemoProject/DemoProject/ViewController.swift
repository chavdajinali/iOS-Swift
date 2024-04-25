//
//  ViewController.swift
//  DemoProject
//
//  Created by Belocum28 on 22/03/24.
//

import UIKit

class ViewController: UIViewController, Storyboardable {
    static let storyboardname: StoryboardName = .Main
    
    var viewModel: ViewModel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    deinit {
        viewModel = nil
        print("\(viewModel?.result)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        viewModel = ViewModel(repository: ViewModelRepository())
        
        viewModel.result.bind { [weak self] int in
            self?.resultLabel.text = "\(self?.viewModel.result.value ?? 0)"
        }
    }
    
    @IBAction func pressMeTapped(_ sender: UIButton) {
        viewModel.additionImplement(100, second: 11)
    }
}

