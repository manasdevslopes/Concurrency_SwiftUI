import UIKit

class BitcoinPriceMonitor {
  
  var price: Double = 0.0
  var timer: Timer?
  var priceHandler: (Double) -> () = { _ in }
  
  func startUpdating() {
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getPrice), userInfo: nil, repeats: true)
    
  }
  
  func stopUpdating() {
    timer?.invalidate()
  }
  
  @objc
  func getPrice() {
    priceHandler(Double.random(in: 20000...40000))
  }
}

/*
let bitcoinPriceMonitor = BitcoinPriceMonitor()
bitcoinPriceMonitor.priceHandler = {
  print($0)
}

bitcoinPriceMonitor.startUpdating()
*/

let bitcoinPriceStream = AsyncStream(Double.self) { continuation in
  let bitcoinPriceMonitor = BitcoinPriceMonitor()
  bitcoinPriceMonitor.priceHandler = {
    continuation.yield($0)
  }
  
   // continuation.onTermination = { _ in }
  
  bitcoinPriceMonitor.startUpdating()
}

Task {
  for await bitcoinPrice in bitcoinPriceStream {
    print(bitcoinPrice)
  }
}
