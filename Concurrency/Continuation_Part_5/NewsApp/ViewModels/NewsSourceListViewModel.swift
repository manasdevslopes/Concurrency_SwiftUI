//
//  NewsSourceListViewmodel.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 18/05/24.
//

import Foundation

class NewsSourceListViewModel: ObservableObject {
  @Published var newsSources: [NewsSourceViewModel] = []
  
  func getSources() async {
    do {
      let newsSources = try await WebserviceNewsApp().fetchSources(url: Constants.Urls.sources)
      DispatchQueue.main.async {
        self.newsSources = newsSources.map(NewsSourceViewModel.init)
      }
    } catch {
      print(error)
    }
    
    /*
    WebserviceNewsApp().fetchSources(url: Constants.Urls.sources) { result in
      switch result {
        case .success(let newsSources):
          DispatchQueue.main.async {
            self.newsSources = newsSources.map(NewsSourceViewModel.init)
          }
        case .failure(let error):
          print(error)
      }
    }
    */
  }
}

struct NewsSourceViewModel {
  
  fileprivate var newsSource: NewsSource
  
  var id: String {
    newsSource.id
  }
  
  var name: String {
    newsSource.name
  }
  
  var description: String {
    newsSource.description
  }
}
