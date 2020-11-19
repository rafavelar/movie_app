//
//  NetworkManager.swift
//  movie_app
//
//  Created by Rafael Avelar on 18/11/20.
//

import Foundation

public final class NetworkManager {
  
  var shows: [Show] = []
  private let domainUrlString = "http://api.tvmaze.com/"
  
  func fetchShows(completionHandler: @escaping ([Show]) -> Void){
    let url = URL(string: domainUrlString + "shows")!
    
    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error with fetching shows: \(error)")
      }
      
      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(response ?? "No error")")
        return
      }
      
      if let data = data,
         let showSummary = try? JSONDecoder().decode(ShowSummary.self, from: data) {
        completionHandler(showSummary.results ?? [])
      }
    })
    task.resume()
  }
  
}
