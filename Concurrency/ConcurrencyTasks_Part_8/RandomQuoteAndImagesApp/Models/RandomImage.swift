//
//  RandomImage.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 20/05/24.
//

import Foundation

struct RandomImage: Codable {
  let image: Data
  let quote: Quote
}

struct Quote: Codable {
  let content: String
}
