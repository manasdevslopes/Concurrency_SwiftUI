import UIKit

enum NetworkError: Error {
  case badUrl
  case noData
  case decodingError
}

struct Post: Codable {
  let title: String
}

// Escaping Closure
func getPosts(completion: @escaping (Result<[Post], NetworkError>) -> () ) {
  guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { completion(.failure(.badUrl))
    return
  }
  
  URLSession.shared.dataTask(with: url) { data, response, error in
    guard let data, error == nil else {
      completion(.failure(.noData))
      return
    }
    
    let posts = try? JSONDecoder().decode([Post].self, from: data)
    completion(.success(posts ?? []))
    
  }.resume()
}

//getPosts { result in
//  switch result {
//    case .success(let posts):
//      print(posts)
//    case .failure(let error):
//      print(error)
//  }
//}


// Async Await Continuation method from iOS 15 instead of Closure way
func getPosts() async throws -> [Post] {
  return try await withCheckedThrowingContinuation { continuation in
    getPosts { result in
      switch result {
        case .success(let posts):
          continuation.resume(returning: posts)
        case .failure(let error):
          continuation.resume(throwing: error)
      }
    }
  }
}

Task {
  do {
    let posts = try await getPosts()
    print("posts====> \(posts)")
  } catch {
    print(error)
  }
}
