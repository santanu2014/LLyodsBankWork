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
    func endPointResponseFor(success: Bool, meassage: String)
}
 class NewsAPIService {
    //MARK: - crete share instance
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
         let urlString = String(format: APIConstants.apiURL,locationName,getTodayDate())
         objHTTPManager.performMethod(UrlString: urlString, body: nil, Parameter: headers, MethodName: .get) { (response, status) in
             guard let response = response as? NSData else {
                 self.delegate?.endPointResponseFor(success: false, meassage: "failure")
                 return
             }
             do {
                 let decoder = JSONDecoder()
                 self.newsResult = try decoder.decode(NewsResult.self, from: response as Data)
                 self.delegate?.endPointResponseFor(success: true, meassage: "success")
             } catch  _ as NSError {
                 self.delegate?.endPointResponseFor(success: false, meassage: "failure")
             }
         } failureBlock: { (response) in
             self.delegate?.endPointResponseFor(success: false, meassage: "failure")
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
