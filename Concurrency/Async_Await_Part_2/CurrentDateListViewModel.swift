//
//  CurrentDateListViewModel.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 16/05/24.
//

import Foundation

@MainActor
class CurrentDateListViewModel: ObservableObject {
  @Published var currentDates: [CurrentDateViewModel] = []
  
  func polulateDates() async {
    do {
      let currentDate = try await Webservice().getDates()
      if let currentDate {
        let currentDateViewModel = CurrentDateViewModel(currentDate: currentDate)
        self.currentDates.append(currentDateViewModel)
      }
    } catch {
      print(error)
    }
  }
}

struct CurrentDateViewModel {
  let currentDate: CurrentDateModel
  
  var id: UUID {
    currentDate.id
  }
  
  var date: String {
    currentDate.date
  }
}
