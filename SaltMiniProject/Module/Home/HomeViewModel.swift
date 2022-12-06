//
//  HomeViewModel.swift
//  SaltMiniProject
//
//  Created by Martin Brianto on 06/12/22.
//

import Foundation

internal struct UserData {
    let name, email, loginToken: String
    
    init(name: String, email: String, loginToken: String) {
        self.name = name
        self.email = email
        self.loginToken = loginToken
    }
}

internal class HomeViewModel {
    
    internal var didUpdate: ((UserData)->())?
    
    internal var userData: UserData {
        didSet {
            didUpdate?(userData)
        }
    }
    
    init() {
        let email = UserDefaults.standard.string(forKey: "email") ?? ""
        let loginToken = UserDefaults.standard.string(forKey: "loginToken") ?? ""
        let userData = UserData(name: "Eve Holt", email: email, loginToken: loginToken)
        self.userData = userData
        didUpdate?(userData)
    }
    
    internal func logOut() {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "loginToken")
    }
    
}
