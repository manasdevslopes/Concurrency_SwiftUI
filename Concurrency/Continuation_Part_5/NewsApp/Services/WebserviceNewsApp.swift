//
//  WebserviceNewsApp.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 18/05/24.
//

import Foundation

enum NetworkError: Error {
  case badUrl
  case invalidData
  case decodingError
}

class WebserviceNewsApp {
  
  func fetchSources(url: URL?) async throws -> [NewsSource] {
    guard let url = url else { throw NetworkError.badUrl }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    let newsSourceResponse = try? JSONDecoder().decode(NewsSourceResponse.self, from: data)

    return newsSourceResponse?.sources ?? []
  }
  
  /*
  func fetchSources(url: URL?, completion: @escaping (Result<[NewsSource], NetworkError>) -> ()) {
    
    guard let url = url else {
      completion(.failure(.badUrl))
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data, error == nil else {
        completion(.failure(.invalidData))
        return
      }
      
      let newsSourceResponse = try? JSONDecoder().decode(NewsSourceResponse.self, from: data)
      completion(.success(newsSourceResponse?.sources ?? []))
      
    }.resume()
  }
  */
  
  func fetchNewsAsync(url: URL?) async throws -> [NewsArticle] {
    try await withCheckedThrowingContinuation { continuation in
      fetchNews(url: url) { result in
        switch result {
          case .success(let newsArticles):
            continuation.resume(returning: newsArticles)
          case .failure(let error):
            continuation.resume(throwing: error)
        }
      }
    }
  }
  
  private func fetchNews(url: URL?, completion: @escaping (Result<[NewsArticle], NetworkError>) -> ()) {
    
    guard let url = url else {
      completion(.failure(.badUrl))
      return
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data, error == nil else {
        completion(.failure(.invalidData))
        return
      }
      
      let newsArticleResponse = try? JSONDecoder().decode(NewsArticleResponse.self, from: data)
      completion(.success(newsArticleResponse?.articles ?? []))
    }.resume()
  }
}
