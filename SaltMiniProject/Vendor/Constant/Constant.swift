//
//  Constant.swift
//  SaltMiniProject
//
//  Created by Martin Brianto on 06/12/22.
//

import Foundation

struct Constant {
    static let Url = "https://reqres.in/api/login"
    
    enum ContentType: String {
            case json = "application/json"
        }
    
    enum ApiError: Int, Error {
        case forbidden = 403              //Status code 403
        case notFound = 404               //Status code 404
        case conflict = 409               //Status code 409
        case internalServerError = 500    //Status code 500
        case badRequest = 400              //Status code 400
    }
}
