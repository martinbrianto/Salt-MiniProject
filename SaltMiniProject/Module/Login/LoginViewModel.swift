//
//  LoginViewModel.swift
//  SaltMiniProject
//
//  Created by Martin Brianto on 06/12/22.
//

import Foundation

internal class LoginViewModel {
    
    internal var didSuccess: ((String) -> Void)?
    internal var isUpdating: (()->())?
    internal var didError: ((String) -> Void)?
    
    private let service: NetworkManager
    
    internal init(service: NetworkManager = NetworkManager()) {
        self.service = service
    }
    
    internal func validateEmail(email: String) -> String? {
        let emailValidationRegex = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
        "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

          let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)

        if email.isEmpty {
            return "Email cannot be empty"
        }
        else if emailValidationPredicate.evaluate(with: email)  == false {
            return "Please enter a valid email"
        }
        
      return nil
    }
    
    internal func validatePassword(password: String) -> String? {
        
        if password.isEmpty {
            return "Password cannot be empty"
        }
        
        return nil
    }
    
    internal func postLogin(email: String, password: String) {
        service.postLogin(body: LoginPost(email: email, password: password)) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                if let error = success.error {
                    self.didError?(error)
                } else if let token = success.token {
                    UserDefaults.standard.set(token, forKey: "loginToken")
                    UserDefaults.standard.set(email, forKey: "email")
                    self.didSuccess?(token)
                }
                
            case .failure(let failure):
                self.didError?(failure.localizedDescription)
                print(failure)
            }
        }
    }
}
