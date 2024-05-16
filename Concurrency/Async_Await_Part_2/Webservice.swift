//
//  Webservice.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 16/05/24.
//

import Foundation

class Webservice {
  
  func getDates() async throws -> CurrentDateModel? {
    guard let url = URL(string: "https://ember-sparkly-rule.glitch.me/current-date") else {
      fatalError("Url is incorrect")
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    return try? JSONDecoder().decode(CurrentDateModel.self, from: data)
  }
}
