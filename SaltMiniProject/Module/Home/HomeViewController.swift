//
//  HomeViewController.swift
//  SaltMiniProject
//
//  Created by Martin Brianto on 06/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileLoginToken: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    
    private let viewModel: HomeViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPage()
        bindViewModel()
    }

    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPage() {
        profilePicture.layer.cornerRadius = 50/2
        let userData = viewModel.userData
        self.profileName.text = userData.name
        self.profileEmail.text = userData.email
        self.profileLoginToken.text = userData.loginToken
        
    }
    
    private func bindViewModel() {
        viewModel.didUpdate? = { [weak self] userData in
            guard let self else { return }
            self.profileName.text = userData.name
            self.profileEmail.text = userData.email
            self.profileLoginToken.text = userData.loginToken
        }
    }
    
    
    @IBAction func logOutBtnAction(_ sender: Any) {
        viewModel.logOut()
        let vc = LoginViewController()
        self.navigationController?.setViewControllers([vc], animated: true)
    }
}
