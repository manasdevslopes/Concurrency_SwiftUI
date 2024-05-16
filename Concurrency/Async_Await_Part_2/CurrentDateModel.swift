//
//  CurrentDateModel.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 16/05/24.
//

import Foundation

// Model
struct CurrentDateModel: Codable, Identifiable {
  let id = UUID()
  let date: String
  
  private enum CodingKeys: String, CodingKey {
    case date = "date"
  }
}
