//
//  NewsSource.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 18/05/24.
//

import Foundation

struct NewsSourceResponse: Codable {
  let status: String
  let sources: [NewsSource]
}

struct NewsSource: Codable, Identifiable {
  let id: String
  let name: String
  let description: String
}
