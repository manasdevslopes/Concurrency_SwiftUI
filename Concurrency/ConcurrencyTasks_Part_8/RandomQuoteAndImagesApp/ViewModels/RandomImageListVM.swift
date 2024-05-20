//
//  RandomImageListVM.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 20/05/24.
//

import SwiftUI

@MainActor
class RandomImageListVM: ObservableObject {
  @Published var randomImages: [RandomImageViewModel] = []
  
  func getRandomImages(ids: [Int]) async {
//    do {
//      let randomImages = try await WebserviceRandomQuoteAndImages().getRandomImages(ids: ids)
//      self.randomImages = randomImages.map(RandomImageViewModel.init)
//    } catch {
//      print(error)
//    }
    let webservice = WebserviceRandomQuoteAndImages()
    randomImages.removeAll()
    do {
      try await withThrowingTaskGroup(of: (Int, RandomImage).self, body: { group in
        for id in ids {
          group.addTask {
            return (id, try await webservice.getRandomImage(id: id))
          }
        }
        
        for try await (_, randomImage) in group {
          randomImages.append(RandomImageViewModel(randomImage: randomImage))
        }
      })
    } catch {
      print(error)
    }
  }
}

struct RandomImageViewModel: Identifiable {
  let id = UUID()
  fileprivate let randomImage: RandomImage
  
  var image: UIImage? {
    UIImage(data: randomImage.image)
  }
  
  var quote: String {
    randomImage.quote.content
  }
}
