//
//  LoginViewController.swift
//  SaltMiniProject
//
//  Created by Martin Brianto on 06/12/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: TextFieldView!
    @IBOutlet weak var passwordTextField: TextFieldView!
    
    @IBOutlet weak var indicatorView: UIVisualEffectView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel = LoginViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        var error = 0
        
        if let emailError = viewModel.validateEmail(email: emailTextField.text) {
            emailTextField.errorMessage = emailError
            error += 1
        } else {
            emailTextField.errorMessage = nil
        }
        
        if let passwordError = viewModel.validatePassword(password: passwordTextField.text) {
            passwordTextField.errorMessage = passwordError
            error += 1
        } else {
            passwordTextField.errorMessage = nil
        }
        
        if error == 0 {
            viewModel.postLogin(email: emailTextField.text, password: passwordTextField.text)
            showIndicator(true)
        }
    }
    
    private func bindViewModel() {
        viewModel.didSuccess = { [weak self] _ in
            guard let self else { return }
            self.showIndicator(false)
            let vc = HomeViewController()
            self.navigationController?.setViewControllers([vc], animated: true)
        }
        
        viewModel.didError = { [weak self] errorMsg in
            guard let self else { return }
            self.showIndicator(false)
            let alert = UIAlertController(title: "Login Failed", message: "\(errorMsg.capitalized)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    private func setupView(){
        emailTextField.textContentType = .emailAddress
        passwordTextField.textContentType = .password
        indicatorView.layer.cornerRadius = 8
        indicatorView.clipsToBounds = true
        
    }
    
    private func showIndicator(_ isUpdating: Bool) {
        if isUpdating {
            indicatorView.isHidden = false
            indicator.startAnimating()
        }else {
            indicatorView.isHidden = true
            indicator.stopAnimating()
        }
    }
}
