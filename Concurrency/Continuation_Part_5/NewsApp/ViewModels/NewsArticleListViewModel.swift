//
//  NewsArticleListViewModel.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 18/05/24.
//

import Foundation

@MainActor
class NewsArticleListViewModel: ObservableObject {
  @Published var newsArticles: [NewsArticleViewModel] = []
  
  func getNewsBy(sourceId: String) async {
    
    do {
      let newsArticles = try await WebserviceNewsApp().fetchNewsAsync(url: Constants.Urls.topHeadlines(by: sourceId))
      self.newsArticles = newsArticles.map(NewsArticleViewModel.init)
    } catch {
      print(error)
    }
    
    print("SOURCEID------>", sourceId)
    /*
     WebserviceNewsApp().fetchNews(url: Constants.Urls.topHeadlines(by: sourceId)) { [weak self] result in
     print("RESULT----->", result)
     switch result {
     case .success(let newsArticles):
     DispatchQueue.main.async {
     self?.newsArticles = newsArticles.map(NewsArticleViewModel.init)
     }
     case .failure(let error):
     print(error)
     }
     }
     */
  }
}

struct NewsArticleViewModel: Identifiable {
  fileprivate var newsArticle: NewsArticle
  
  var id: UUID {
    newsArticle.id
  }
  
  var title: String {
    newsArticle.title
  }
  
  var description: String {
    newsArticle.description
  }
  
  var urlToImage: URL? {
    newsArticle.urlToImage
  }
}
