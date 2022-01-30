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
    var expectation: XCTestExpectation?
    var responseStatus: Bool?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiServiceTest.delegate = self
    }
    //Test API calling method
    func testGetNewsListSuccess() {
        expectation  = expectation(description: "Get true response")
        //Test case : when getting success response
        let mockobj = HTTPManagerMockForSucces()
        apiServiceTest.objHTTPManager = mockobj
        apiServiceTest.getNewsList(locationName: "UK")
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(responseStatus, true)
    }
    func testGetNewsListFailure() {
        //Test case : when getting failure response
        expectation  = expectation(description: "Get false response")
        let mockobjFail = HTTPManagerMockForFailure()
        apiServiceTest.objHTTPManager = mockobjFail
        apiServiceTest.getNewsList(locationName: "UK")
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(responseStatus, false)
    }
    func testGetNewsListNil(){
        //Test case : when getting nil response
        expectation  = expectation(description: "Get Nil response")
        let mockobjNil = HTTPManagerMockForNil()
        apiServiceTest.objHTTPManager = mockobjNil
        apiServiceTest.getNewsList(locationName: "UK")
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(responseStatus, false)
    }
    func testGetNewsListAPIeEror() {
        //Test case : when getting server error response
        expectation  = expectation(description: "Get Server Failure")
        let mockobjError = HTTPManagerMockForServerFailure()
        apiServiceTest.objHTTPManager = mockobjError
        apiServiceTest.getNewsList(locationName: "UK")
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(responseStatus, false)
    }
    func testGetTodayDate() {
        let date = apiServiceTest.getTodayDate()
        XCTAssert(date.count > 0 , "Current date succesfully converted to string format")
    }
    //Call back methods for delegate
    func endPointResponseFor(isSuccess: Bool, meassage: String) {
        responseStatus = isSuccess
        expectation?.fulfill()
        expectation = nil
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

//Mock data for HTTPManager Succes
class HTTPManagerMockForSucces: HTTPManager {
    override func performMethod(UrlString url: String, body: [String : Any]?, Parameter headers: HTTPHeaders?, MethodName method: HTTPMethod?, successBlock: SuccessBlock?, failureBlock: FailureBlock?) {
        let data = FileManager.readJson(forResource: "TestingData")
        successBlock!(data as AnyObject, 200)
    }
}
//Mock data for HTTPManager Failure
class HTTPManagerMockForFailure: HTTPManager {
    override func performMethod(UrlString url: String, body: [String : Any]?, Parameter headers: HTTPHeaders?, MethodName method: HTTPMethod?, successBlock: SuccessBlock?, failureBlock: FailureBlock?) {
        let data = NSData()
        successBlock!(data as AnyObject, 201)
    }
}
//Mock data for HTTPManager Nil
class HTTPManagerMockForNil: HTTPManager {
    override func performMethod(UrlString url: String, body: [String : Any]?, Parameter headers: HTTPHeaders?, MethodName method: HTTPMethod?, successBlock: SuccessBlock?, failureBlock: FailureBlock?) {
        let data = FileDataService.shared.fetchConverter(filename: "TestingData")
        successBlock!(data as AnyObject, 201)
    }
}
//Mock data for HTTPManager Server Failure
class HTTPManagerMockForServerFailure: HTTPManager {
    override func performMethod(UrlString url: String, body: [String : Any]?, Parameter headers: HTTPHeaders?, MethodName method: HTTPMethod?, successBlock: SuccessBlock?, failureBlock: FailureBlock?) {
        let  error = NSError.self
        failureBlock?(error)
    }
}

