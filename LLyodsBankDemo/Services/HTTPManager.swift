//
//  HTTPManager.swift
//  LLyodsBankDemo
//
//  Created by Santanu on 21/01/2022.
//

import Foundation
import Alamofire

class HTTPManager {
    /// Calling backend web service
    /// - Parameters:
    ///   - url: url
    ///   - body: body
    ///   - headers: headers
    ///   - method: method
    ///   - successBlock: successBlock
    ///   - failureBlock: failureBlock 
    func performMethod(UrlString url: String, body: [String: Any]?, Parameter headers: HTTPHeaders?, MethodName method: HTTPMethod?, successBlock: SuccessBlock?, failureBlock: FailureBlock?) {
        if let urlName = URL(string: url) {
            var urlRequest = URLRequest(url: urlName)
            urlRequest.timeoutInterval =  30
            urlRequest.httpMethod = method?.rawValue
                if Connectivity.isConnectedToInternet() == false {
                    failureBlock?(nil)
                }
                AF.request(url, method: HTTPMethod(rawValue: method!.rawValue), parameters: body, encoding: JSONEncoding.default, headers: headers).responseData { response in
                    switch response.result {
                    case .success(let jason):
                        if jason.isEmpty { return }
                        successBlock?(response.data as AnyObject?, response.response!.statusCode)
                    case .failure(let error as NSError):
                        failureBlock?(error)
                    }
                }
        }
    }
}
