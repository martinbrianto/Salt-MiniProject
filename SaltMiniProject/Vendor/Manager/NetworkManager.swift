//
//  NetworkManager.swift
//  SaltMiniProject
//
//  Created by Martin Brianto on 06/12/22.
//

import Alamofire
import RxSwift
import Foundation

internal class NetworkManager {
    internal func postLogin(body: LoginPost, completion: @escaping (Result<LoginResponse,Error>)->()) {
        
        let parameters = ["email": body.email,
                          "password":body.password]
        
        
        AF.request(Constant.Url, method: .post,parameters: parameters, encoding: URLEncoding.default)
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success:
                    if let value = response.value {
                        completion(.success(value))
                    }
                case .failure(let error):
                    if let statusCode = response.response?.statusCode, let apiError = Constant.ApiError(rawValue: statusCode) {
                        completion(.failure(apiError))
                    }
                    completion(.failure(error))
                }
            }
    }
}

internal class NetworkManagerMockSuccess: NetworkManager {
    override func postLogin(body: LoginPost, completion: @escaping (Result<LoginResponse, Error>) -> ()) {
        completion(.success(LoginResponse(token: "asd123asd", error: nil)))
    }
}
