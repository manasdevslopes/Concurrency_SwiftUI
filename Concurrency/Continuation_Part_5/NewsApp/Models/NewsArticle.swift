//
//  NewsArticle.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 18/05/24.
//

import Foundation

// Article Source Model
struct Source: Codable {
  let id: String?
  let name: String
}

// Article Model
struct NewsArticle: Codable, Identifiable {
  var id = UUID()
  let title: String
  let description: String
  let urlToImage: URL?
  
  enum CodingKeys: String, CodingKey {
    case title
    case description
    case urlToImage
  }
}

// JSON Response Model
struct NewsArticleResponse: Codable {
  let status: String
  let totalResults: Int
  let articles: [NewsArticle]
}
