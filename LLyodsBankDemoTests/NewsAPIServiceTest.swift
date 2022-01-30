//
//  NewsAPIServiceTest.swift
//  LLyodsBankDemoTests
//
//  Created by Santanu on 27/01/2022.
//

import XCTest
import Alamofire

@testable import LLyodsBankDemo


class NewsAPIServiceTest: XCTestCase,HttpResponseDelegate {
    let apiServiceTest = NewsAPIService()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    //Test API calling method
    func testGetNewsList() {
        apiServiceTest.delegate = self
        //Test case : when getting success response
        let mockobj = HTTPManagerMockForSucces()
        apiServiceTest.objHTTPManager = mockobj
        apiServiceTest.getNewsList(locationName: "UK")
        waitForExpectations(timeout: 2, handler: nil)

        //Test case : when getting failure response
        let mockobjFail = HTTPManagerMockForFailure()
        apiServiceTest.objHTTPManager = mockobjFail
        apiServiceTest.getNewsList(locationName: "UK")
        waitForExpectations(timeout: 2, handler: nil)

        //Test case : when getting nil response
        let mockobjNil = HTTPManagerMockForNil()
        apiServiceTest.objHTTPManager = mockobjNil
        apiServiceTest.getNewsList(locationName: "UK")
        waitForExpectations(timeout: 2, handler: nil)
        
        //Test case : when getting server error response
        let mockobjError = HTTPManagerMockForFailureBlock()
        apiServiceTest.objHTTPManager = mockobjError
        apiServiceTest.getNewsList(locationName: "UK")
        waitForExpectations(timeout: 2, handler: nil)
    }
    func testGetTodayDate() {
        let date = apiServiceTest.getTodayDate()
        XCTAssert(date.count > 0 , "Current date succesfully converted to string format")
    }
    //Call back methods for delegate
    func endPointResponseFor(success: Bool, meassage: String) {
        let expectationForParkingSpace = expectation(description: "Get response")
        expectationForParkingSpace.fulfill()
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

//Mock data for HTTPManager
class HTTPManagerMockForSucces: HTTPManager {
    override func performMethod(UrlString url: String, body: [String : Any]?, Parameter headers: HTTPHeaders?, MethodName method: HTTPMethod?, successBlock: SuccessBlock?, failureBlock: FailureBlock?) {
        let data = FileManager.readJson(forResource: "TestingData")
        successBlock!(data as AnyObject, 200)
    }
}
//Mock data for HTTPManager
class HTTPManagerMockForFailure: HTTPManager {
    override func performMethod(UrlString url: String, body: [String : Any]?, Parameter headers: HTTPHeaders?, MethodName method: HTTPMethod?, successBlock: SuccessBlock?, failureBlock: FailureBlock?) {
        let data = NSData()
        successBlock!(data as AnyObject, 201)
    }
}
//Mock data for HTTPManager
class HTTPManagerMockForNil: HTTPManager {
    override func performMethod(UrlString url: String, body: [String : Any]?, Parameter headers: HTTPHeaders?, MethodName method: HTTPMethod?, successBlock: SuccessBlock?, failureBlock: FailureBlock?) {
        let data = FileDataService.shared.fetchConverter(filename: "TestingData")
        successBlock!(data as AnyObject, 201)
    }
}
//Mock data for HTTPManager
class HTTPManagerMockForFailureBlock: HTTPManager {
    override func performMethod(UrlString url: String, body: [String : Any]?, Parameter headers: HTTPHeaders?, MethodName method: HTTPMethod?, successBlock: SuccessBlock?, failureBlock: FailureBlock?) {
        let  error = NSError.self
        failureBlock?(error)
    }
}

