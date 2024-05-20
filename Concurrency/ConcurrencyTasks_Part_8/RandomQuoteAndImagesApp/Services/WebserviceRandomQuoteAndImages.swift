//
//  WebserviceRandomQuoteAndImages.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 20/05/24.
//

import Foundation

enum WebserviceRandomQuoteAndImagesNetworkError: Error {
  case badUrl
  case invalidImageIf(Int)
  case decodingError
}
class WebserviceRandomQuoteAndImages {
  
  func getRandomImages(ids: [Int]) async throws -> [RandomImage] {
    var randomImages: [RandomImage] = []
    
    try await withThrowingTaskGroup(of: (Int, RandomImage).self, body: { group in
      for id in ids {
        group.addTask { [self] in
          return (id, try await getRandomImage(id: id))
        }
      }
      /* Async Sequence */
      for try await (_, randomImage) in group {
        randomImages.append(randomImage)
      }
    })
    
    return randomImages
  }
  
  func getRandomImage(id: Int) async throws -> RandomImage {
    guard let url = RandomQuoteAndImagesConstants.Urls.getRandomImageUrl() else { throw WebserviceRandomQuoteAndImagesNetworkError.badUrl }
    
    guard let randomQuoteUrl = RandomQuoteAndImagesConstants.Urls.randomQuoteUrl else { throw WebserviceRandomQuoteAndImagesNetworkError.badUrl }
    
    async let (imageData, _) = URLSession.shared.data(from: url)
    async let (randomQuoteData, _) = URLSession.shared.data(from: randomQuoteUrl)
    
    guard let quote = try? JSONDecoder().decode(Quote.self, from: try await randomQuoteData) else { throw NetworkError.decodingError }
    
    return RandomImage(image: try await imageData, quote: quote)
  }
}
