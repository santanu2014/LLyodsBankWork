//
//  LlyodsExtension.swift
//  LLyodsBankDemo
//
//  Created by Santanu on 20/01/2022.
//

import Foundation
import UIKit

extension UIView {
    /// Add Activity Indicator
    /// - Parameters:
    ///   - activityColor: color
    ///   - backgroundColor: background color
    ///   - titleName: title
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor, titleName: String) {
        DispatchQueue.main.async {
            let backgroundView = UIView()
            backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
            backgroundView.backgroundColor = backgroundColor
            backgroundView.tag = 9898989
            var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: backgroundView.frame.width/2 - 25.0, y: backgroundView.frame.height / 2 - 25.0, width: 50, height: 50))
            activityIndicator.hidesWhenStopped = true
            if #available(iOS 13.0, *) {
                activityIndicator.style = .large
            } else {
                activityIndicator.style = .whiteLarge
            }
            activityIndicator.color = activityColor
            activityIndicator.startAnimating()

            let titleLabel = UILabel(frame: CGRect(x: 0, y: activityIndicator.frame.origin.y + 25, width: backgroundView.frame.width, height: 60))
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            titleLabel.text = titleName
            backgroundView.addSubview(activityIndicator)
            self.addSubview(backgroundView)
            backgroundView.addSubview(titleLabel)
        }

    }
    /// Stop Activity Indicator
    func activityStopAnimating() {
        DispatchQueue.main.async {
            if let background = self.viewWithTag(9898989) {
                    background.removeFromSuperview()
            }
        }
    }
}
