//
//  LoginTests.swift
//  SaltMiniProjectTests
//
//  Created by Martin Brianto on 06/12/22.
//

import XCTest
@testable import SaltMiniProject

class LoginTest: XCTestCase {
    
    let viewModel = LoginViewModel(service: NetworkManagerMockSuccess())
    
    func testEmailValidation_empty() {
        let result = viewModel.validateEmail(email: "")
        XCTAssertEqual(result, "Email cannot be empty")
    }
    
    func testEmailValidation_format() {
        let result1 = viewModel.validateEmail(email: "asd@asd") ?? ""
        let result2 = viewModel.validateEmail(email: "asd")
        
        
        XCTAssertEqual(result1, "Please enter a valid email")
        XCTAssertEqual(result2, "Please enter a valid email")
    }
    
    func testLoginSuccess() {
        UserDefaults.standard.removeObject(forKey: "loginToken")
        UserDefaults.standard.removeObject(forKey: "email")
        viewModel.postLogin(email:"email@email.com", password: "passw0rd")
        
        let email = UserDefaults.standard.string(forKey: "email")
        let loginToken = UserDefaults.standard.string(forKey: "loginToken")
        
        XCTAssertEqual(loginToken, "asd123asd")
        XCTAssertEqual(email, "email@email.com")
    }
    
    
}
