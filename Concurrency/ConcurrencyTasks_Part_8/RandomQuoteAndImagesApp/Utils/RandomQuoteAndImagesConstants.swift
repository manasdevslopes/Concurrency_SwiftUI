//
//  RandomQuoteAndImagesConstants.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 20/05/24.
//

import Foundation

struct RandomQuoteAndImagesConstants {
  
  struct Urls {
    
    static func getRandomImageUrl() -> URL? {
      return URL(string: "https://picsum.photos/200/300?uuid=\(UUID().uuidString)")
    }
    
    static let randomQuoteUrl: URL? = URL(string: "https://api.quotable.io/random")
  }
}
