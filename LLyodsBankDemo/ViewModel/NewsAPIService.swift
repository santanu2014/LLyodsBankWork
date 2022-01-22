//
//  NewsAPIService.swift
//  LLyodsBankDemo
//
//  Created by Santanu on 20/01/2022.
//

import Foundation
import Alamofire

typealias SuccessBlock =  (_ response: AnyObject?, _ status: Int) -> Void
typealias FailureBlock = (_ response: AnyObject?) -> Void

 class NewsAPIService {
    static let shareViewModel = NewsAPIService()
    var newsResult: NewsResult?
     
     /// Prepare API request and Pursing data
     /// - Parameters:
     ///   - locationName: locationName  / City name
     ///   - successBlock: successBlock
     ///   - failureBlock: failureBlock 
    func getNewsList(locationName: String, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) {
        let headers: HTTPHeaders = []
        let urlString = String(format: APIConstants.apiURL,locationName,getTodayDate())
        HTTPManager().performMethod(UrlString: urlString, body: nil, Parameter: headers, MethodName: .get) { (response, status) in
            guard let response = response as? NSData else { return }
            do {
                let decoder = JSONDecoder()
                self.newsResult = try decoder.decode(NewsResult.self, from: response as Data)
                successBlock(nil, status)
            } catch let error as NSError {
                failureBlock(error)
            }
        } failureBlock: { (response) in
            failureBlock(response)
        }
       }
     
     /// Get current date
     /// - Returns: date in string format
     func getTodayDate() -> String {
         // create dateFormatter with UTC time format
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         let date = NSDate() as Date
         dateFormatter.dateFormat = "yyyy-MM-dd"
         dateFormatter.timeZone = TimeZone.current
         let todayDate = dateFormatter.string(from: date)
         return todayDate
     }
}
//Check Internet connectivty
class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
