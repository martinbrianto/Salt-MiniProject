//
//  DataModel.swift
//  SaltMiniProject
//
//  Created by Martin Brianto on 06/12/22.
//

import Foundation

internal struct LoginPost: Codable {
    let email, password: String
}

internal struct LoginResponse: Codable {
    let token: String?
    let error: String?
}
