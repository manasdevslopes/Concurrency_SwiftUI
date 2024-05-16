//
//  DatesApp.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 13/05/24.
//

import SwiftUI

struct DatesApp: View {
  @StateObject private var currentDateListVM = CurrentDateListViewModel()
  
  var body: some View {
    NavigationView {
      List(currentDateListVM.currentDates, id: \.id) { currentDate in
        Text(currentDate.date)
      }.listStyle(.plain)
        .navigationTitle("Dates")
        .navigationBarItems(trailing: Button(action: {
          Task {
            await currentDateListVM.polulateDates()
          }
        }, label: {
          Image(systemName: "arrow.clockwise.circle")
        }))
        .task {
          await currentDateListVM.polulateDates()
        }
    }
  }
}

struct DatesApp_Previews: PreviewProvider {
  static var previews: some View {
    DatesApp()
  }
}
