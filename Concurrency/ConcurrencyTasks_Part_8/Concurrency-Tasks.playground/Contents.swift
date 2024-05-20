import SwiftUI

enum NetworkError: Error {
  case badUrl
  case decodingError
  case invalidId
}

struct CreditScore: Decodable {
  let score: Int
}

struct Constants {
  
  struct Urls {
    
    static func equifax(userId: Int) -> URL? {
      return URL(string: "https://ember-sparkly-rule.glitch.me/equifax/credit-score/\(userId)")
    }
    
    static func experian(userId: Int) -> URL? {
      return URL(string: "https://ember-sparkly-rule.glitch.me/experian/credit-score/\(userId)")
    }
  }
}

func calculateAPR(creditScores: [CreditScore]) -> Double {
  let sum = creditScores.reduce(0) { $0 + $1.score }
  print("SUM=====>", sum/creditScores.count)
  return Double((sum/creditScores.count) / 100)
}

func getAPR(userId: Int) async throws -> Double {
  // Just for Task Cancellation purpose, how to do Task Cancellation. For id 1 it will work but after id 2, this function won't return anything. For that need to use Task.checkCancellation()
//  if userId % 2 == 0 {
//    throw NetworkError.invalidId
//  }
  
  guard let equifaxUrl = Constants.Urls.equifax(userId: userId),
  let experianUrl = Constants.Urls.experian(userId: userId) else {
    throw NetworkError.badUrl
  }
  
  /* By async let - Both below tasks will run Concurrently, and no need to write try await*/
  /* Due to which it is not blocking / suspending any tasks*/
  async let (equifaxData, _) = URLSession.shared.data(from: equifaxUrl)
  async let (experianData, _) = URLSession.shared.data(from: experianUrl)
  
  // Decode them
  let equifaxCreditScore = try? JSONDecoder().decode(CreditScore.self, from: try await equifaxData)
  let experianCreditScore = try? JSONDecoder().decode(CreditScore.self, from: try await experianData)
  
  guard let equifaxCreditScore,
        let experianCreditScore else { throw NetworkError.decodingError }

  return calculateAPR(creditScores: [equifaxCreditScore, experianCreditScore])
}

Task {
  let apr = try await getAPR(userId: 11)
  // print(apr)
}


/* if multiple ids to be used to callgetAP func, this will also block / suspend each call one after the other. To avoid this, we need to use Task Group
 */
let ids = [1,2,3,4,5]
var invalidIds: [Int] = []

Task {
  for id in ids {
    do {
      // Task.isCancelled - A Bool value that indicates whether the current task should stop executing.
      // print(Task.isCancelled)
      try Task.checkCancellation()
      let apr = try await getAPR(userId: id)
      print(apr)
    } catch {
      print(error)
      invalidIds.append(id)
    }
  }
  
  print(invalidIds)
}

/* Task Group */
func getAPRForAllUsers(ids: [Int]) async throws -> [Int: Double] {
  var userAPR: [Int: Double] = [:]
  
  try await withThrowingTaskGroup(of: (Int, Double).self, body: { group in
    for id in ids {
      group.addTask {
        return (id, try await getAPR(userId: id))
      }
    }
    /* Async Sequence */
    for try await (id, apr) in group {
      userAPR[id] = apr
    }
  })
  
  return userAPR
}

Task {
  let aprs = try await getAPRForAllUsers(ids: ids)
  print("APRS----->", aprs)
}
