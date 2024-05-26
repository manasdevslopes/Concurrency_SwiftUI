//
//  fooApp.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 26/05/24.
//

import SwiftUI

// use Actors to have concurrent operations and no race condition 
actor Counter {
  var value: Int = 0
  
  func increment() -> Int {
    value += 1
    return value
  }
}

struct FooApp: View {
  var body: some View {
    Button {
      let counter = Counter()
      DispatchQueue.concurrentPerform(iterations: 100) { _ in
        Task {
          print(await counter.increment())
        }
      }
    } label: {
      Text("Increment")
    }
  }
}

struct FooApp_Previews: PreviewProvider {
  static var previews: some View {
    FooApp()
  }
}
