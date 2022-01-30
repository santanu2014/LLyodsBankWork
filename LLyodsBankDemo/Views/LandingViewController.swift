//
//  ViewController.swift
//  LLyodsBankDemo
//
//  Created by Santanu on 20/01/2022.
//

import UIKit
import Alamofire

class LandingViewController: UIViewController, HttpResponseDelegate {
    @IBOutlet weak var newsTableView: UITableView!
    private var refreshControl = UIRefreshControl()
    //Initiated View Model
    lazy var viewModel: NewsAPIService = {
        let viewModel = NewsAPIService()
        return viewModel
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configUI()
        //Call API service
        callAPI()
    }
    //MARK: - Design the UI
    func configUI() {
        newsTableView.accessibilityLabel = "newsTableView"
        //Add pull to refresh Action
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        let myAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15) ]
        let loadingtitke = NSMutableAttributedString(string: TextConstant.loadingData, attributes: myAttribute )
        refreshControl.attributedTitle = loadingtitke
        newsTableView.addSubview(refreshControl)
        self.view.activityStartAnimating(activityColor: UIColor.gray, backgroundColor: .secondarySystemBackground, titleName: TextConstant.loadingData)
    }
    //MARK: - Pull to Refresh Action
    /// - Parameter sender: Refresh Action
    @objc func refresh(_ sender: AnyObject) {
        self.callAPI()
    }
    
    /// Callback method for API call
    /// - Parameters:
    ///   - success: true / false will return based on succes for failure
    ///   - meassage: "In case error happen"
    func endPointResponseFor(isSuccess: Bool, meassage: String) {
        self.view.activityStopAnimating()
        self.refreshControl.endRefreshing()
        if isSuccess == true {
            self.newsTableView.reloadData()
        } else {
            showAlert(withTitle: TextConstant.title, withMessage: meassage)
        }
    }
    //MARK:- Calling web api
    func callAPI() {
        //MARK: - User has to pass city/place/country name, API will return coresponding current day news.
        viewModel.delegate = self
        viewModel.getNewsList(locationName: "UK")
    }

}

//MARK: - Deleagte for tableview
extension LandingViewController: UITableViewDelegate {}
extension LandingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        //Adding first cell accessibilityValue for UI testing
        if indexPath.row == 0 { cell.accessibilityValue = "NewsTableViewCell_forCell_0_Index" }
        guard let article = viewModel.newsResult?.articles?[indexPath.row] else {
            return cell
        }
        cell.populateCellContent(articles: article)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.newsResult?.articles?.count ?? 0
    }
}
