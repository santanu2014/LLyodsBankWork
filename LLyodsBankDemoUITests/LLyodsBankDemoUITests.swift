//
//  LLyodsBankDemoUITests.swift
//  LLyodsBankDemoUITests
//
//  Created by Santanu on 20/01/2022.
//

import XCTest

class LLyodsBankDemoUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    func testTableView() {
        app.launch()
        let tablelist = app.descendants(matching: .table)
        print(tablelist)
        wait(for: 7)
        let newsTableView = tablelist["newsTableView"]
        //Select first table cell
        let cell = newsTableView.cells.element(matching: .cell, identifier: "NewsTableViewCell_forCell_0_Index")
        cell.tap()
        wait(for: 2)
        //Tableview swipe up
        newsTableView.swipeUp()
        wait(for: 1)
        //Tableview swipe up
        newsTableView.swipeUp()
        wait(for: 1)
        //Tableview swipe up
        newsTableView.swipeUp()
        wait(for: 1)
        //Tableview swipe down
        newsTableView.swipeDown()
        wait(for: 1)
        //Tableview swipe down
        newsTableView.swipeDown()
        //Tableview swipe down
        wait(for: 1)
        //Tableview swipe down
        newsTableView.swipeDown()
        wait(for: 1)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
extension XCTestCase {

  func wait(for duration: TimeInterval) {
    let waitExpectation = expectation(description: "Waiting")

    let when = DispatchTime.now() + duration
    DispatchQueue.main.asyncAfter(deadline: when) {
      waitExpectation.fulfill()
    }
    // We use a buffer here to avoid flakiness with Timer on CI
    waitForExpectations(timeout: duration + 0.5)
  }
}
