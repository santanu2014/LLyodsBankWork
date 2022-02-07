//
//  NewsAPIService.swift
//  LLyodsBankDemo
//
//  Created by Santanu on 20/01/2022.
//

import Foundation
import Alamofire

//MARK: - Success block
typealias SuccessBlock =  (_ response: AnyObject?, _ status: Int) -> Void
//MARK: - Failure block
typealias FailureBlock = (_ response: AnyObject?) -> Void

protocol HttpResponseDelegate: AnyObject {
    func endPointResponseFor(isSuccess: Bool, message: String)
}
 class NewsAPIService {
    //MARK: - create share instance
    weak var delegate: HttpResponseDelegate?
    var newsResult: NewsResult?
    var objHTTPManager = HTTPManager()
     
     /// Prepare API request and Pursing data
     /// - Parameters:
     ///   - locationName: locationName  / City name
     ///   - successBlock: successBlock
     ///   - failureBlock: failureBlock
     func getNewsList(locationName: String) {
         let headers: HTTPHeaders = []
        // let urlString = String(format: APIConstants.apiURL,locationName,getTodayDate(),APIInfo.APIKey)
         let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2022-01-06&sortBy=publishedAt&apiKey=a0592bfa090d44aba7a3bca5ad5c42f0"
         objHTTPManager.performMethod(UrlString: urlString, body: nil, Parameter: headers, MethodName: .get) { (response, status) in
             guard let response = response as? NSData else {
                 self.delegate?.endPointResponseFor(isSuccess: false, message: "failure")
                 return
             }
             do {
                 let decoder = JSONDecoder()
                 self.newsResult = try decoder.decode(NewsResult.self, from: response as Data)
                 self.delegate?.endPointResponseFor(isSuccess: true, message: "success")
             } catch let error as NSError {
                 print(error)
                 self.delegate?.endPointResponseFor(isSuccess: false, message: "failure")
             }
         } failureBlock: { (response) in
             self.delegate?.endPointResponseFor(isSuccess: false, message: "failure")
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
         return  todayDate
     }
}
//Check Internet connectivty
class Connectivity {
    class func isConnectedToInternet() -> Bool {
        guard let status = NetworkReachabilityManager()?.isReachable else { return false }
        return status
    }
}
