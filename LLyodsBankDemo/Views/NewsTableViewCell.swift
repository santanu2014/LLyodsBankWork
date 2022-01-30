//
//  NewsTableViewCell.swift
//  LLyodsBankDemo
//
//  Created by Santanu on 20/01/2022.
//

import Foundation
import UIKit
import Alamofire

class NewsTableViewCell: UITableViewCell {
    @IBOutlet var cardView: UIView!
    @IBOutlet var newsIcon: UIImageView!
    @IBOutlet var newsTitle: UILabel!
    @IBOutlet var newsDescription: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    override  func awakeFromNib() {
        super.awakeFromNib()
        self.card(view: cardView, radius: 3)
    }
    
    /// Add content of the cell
    /// - Parameter articles: Articles object
    func populateCellContent(articles: Articles) {
        newsTitle.text = articles.title
        newsDescription.text = articles.description
        if let sourceName =  articles.source?.name { sourceLabel.text = TextConstant.source + sourceName }
        if let url = articles.urlToImage {
            let imageURL = url.replacingOccurrences(of: " ", with: "%20")
            AF.request(imageURL, method: .get).response { response in
                switch response.result {
                case .success(let responseData):
                    guard let res = responseData else { return }
                    self.newsIcon.image =  UIImage(data: res, scale: 1)
                case .failure(let error):
                    print("error--->", error)
                }
            }
        }
    }
    /// Design the card
    /// - Parameters:
    ///   - view: Current View
    ///   - radius: Change the shape of the card
    func card(view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = Float(0.8)
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 2.0
        view.layer.masksToBounds = false
        view.clipsToBounds = false
    }
}

