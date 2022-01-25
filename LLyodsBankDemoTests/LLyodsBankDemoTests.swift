//
//  LLyodsBankDemoTests.swift
//  LLyodsBankDemoTests
//
//  Created by Santanu on 20/01/2022.
//

import XCTest
@testable import LLyodsBankDemo

class LLyodsBankDemoTests: XCTestCase {
    var landingViewControllerTest: LandingViewController!
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        landingViewControllerTest = storyboard.instantiateViewController(withIdentifier: "LandingViewController") as? LandingViewController
        landingViewControllerTest.loadView()
        landingViewControllerTest.viewDidLoad()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        landingViewControllerTest = nil
    }

    func testHasATableView() {
        XCTAssertNotNil(landingViewControllerTest.newsTableView)
     }
    //Test tableview delegate
    func testTableViewHasDelegate() {
            XCTAssertNotNil(landingViewControllerTest.newsTableView.delegate)
        }
    //test table view data source
    func testTableViewHasDataSource() {
            XCTAssertNotNil(landingViewControllerTest.newsTableView.dataSource)
        }
    //Test delegate methods
    func testTableViewConformsToTableViewDataSourceProtocol() {
            XCTAssertTrue(landingViewControllerTest.conforms(to: UITableViewDataSource.self))
            XCTAssertTrue(landingViewControllerTest.responds(to: #selector(landingViewControllerTest.numberOfSections(in:))))
            XCTAssertTrue(landingViewControllerTest.responds(to: #selector(landingViewControllerTest.tableView(_:numberOfRowsInSection:))))
            XCTAssertTrue(landingViewControllerTest.responds(to: #selector(landingViewControllerTest.tableView(_:cellForRowAt:))))
        }
    //Test identifier name
    func testTableViewCellHasReuseIdentifier() {
            let cell = landingViewControllerTest.tableView(landingViewControllerTest.newsTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? NewsTableViewCell
            let actualReuseIdentifer = cell?.reuseIdentifier
            let expectedReuseIdentifier = "NewsTableViewCell"
            XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
        }
    //Test number of the row in the table view
    func testNumberofRowofTableView() {
        let testData = FileDataService.shared.fetchConverter(filename: "TestingData")
        landingViewControllerTest.viewModel.newsResult = testData
        let numberOfRow = landingViewControllerTest?.tableView((landingViewControllerTest?.newsTableView)!, numberOfRowsInSection: 0)
          XCTAssertEqual(numberOfRow, 3, "Number of rows in tableview should match with three")

       }
    //Test table cell
    func testTableCellHasCorrectLabelText() {
            let testData = FileDataService.shared.fetchConverter(filename: "TestingData")
            landingViewControllerTest.viewModel.newsResult = testData
            let cell0 = landingViewControllerTest.tableView(landingViewControllerTest.newsTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? NewsTableViewCell
            XCTAssertEqual(cell0?.newsTitle.text, "UK’s Truss warns Russia of ‘terrible quagmire’ if it invades Ukraine")
            let cell1 = landingViewControllerTest.tableView(landingViewControllerTest.newsTableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? NewsTableViewCell
            XCTAssertEqual(cell1?.newsTitle.text, "Pro AV Market to Record 6.57% Y-O-Y Growth Rate in 2021 |41% of Growth to Originate from APAC |17000+ Technavio Reports")
            let cell2 = landingViewControllerTest.tableView(landingViewControllerTest.newsTableView, cellForRowAt: IndexPath(row: 2, section: 0)) as? NewsTableViewCell
            XCTAssertEqual(cell2?.newsTitle.text, "BGHL (GBP): NAV(s)")
        }
    func testMethod() {
        landingViewControllerTest.callAPI()
        landingViewControllerTest.refresh(UIButton())
    }
}
//Cretae Mock data for unit test
extension FileManager {
    static func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: FileDataService.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

final class FileDataService {
    static let shared = FileDataService()
    func fetchConverter(filename: String) -> NewsResult? {
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: filename) else {
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let newsResult  = try decoder.decode(NewsResult.self, from: data)
            return newsResult
        } catch {
            print("error:\(error)")
            return nil
        }
    }
}
