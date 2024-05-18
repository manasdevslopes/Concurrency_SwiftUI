//
//  Constants.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 18/05/24.
//

import Foundation

struct Constants {
  
  struct Urls {
    
    static func topHeadlines(by source: String) -> URL? {
      print("source------>", source)
      return URL(string: "https://newsapi.org/v2/top-headlines?sources=\(source)&apiKey=0cf790498275413a9247f8b94b3843fd")
    }
    
    static let sources: URL? = URL(string: "https://newsapi.org/v2/sources?apiKey=0cf790498275413a9247f8b94b3843fd")
    
  }
}
