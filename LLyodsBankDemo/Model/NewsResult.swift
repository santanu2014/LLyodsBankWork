//
//  NewsResult.swift
//  LLyodsBankDemo
//
//  Created by Santanu on 20/01/2022.
//

import Foundation
struct NewsResult : Codable {
    let status : String?
    let totalResults : Int?
    let articles : [Articles]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        articles = try values.decodeIfPresent([Articles].self, forKey: .articles)
    }

}
