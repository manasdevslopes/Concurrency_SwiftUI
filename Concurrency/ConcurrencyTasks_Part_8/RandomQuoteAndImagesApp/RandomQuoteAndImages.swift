//
//  RandomQuoteAndImages.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 20/05/24.
//

import SwiftUI

struct RandomQuoteAndImages: View {
  @StateObject private var randomImageListVM = RandomImageListVM()
  
    var body: some View {
      NavigationStack {
        List(randomImageListVM.randomImages) { randomImage in
          HStack {
            randomImage.image.map {
              Image(uiImage: $0).resizable().aspectRatio(contentMode: .fit)
            }
            Text(randomImage.quote)
          }
        }
        .task {
          await randomImageListVM.getRandomImages(ids: Array(100...120))
        }
        .navigationTitle("Random Images/Quotes")
        .navigationBarItems(trailing: Button(action: {
          Task {
            await randomImageListVM.getRandomImages(ids: Array(100...120))
          }
        }, label: {
          Image(systemName: "arrow.clockwise.circle")
        }))
      }
    }
}

struct RandomQuoteAndImages_Previews: PreviewProvider {
    static var previews: some View {
        RandomQuoteAndImages()
    }
}
