//
//  ApiResponses.swift
//  movie_app
//
//  Created by Rafael Avelar on 18/11/20.
//

import Foundation

struct ShowSummary: Codable {
  let count: Int?
  let results: [Show]?
}

struct Show: Codable {
  let id: Int
  let url: String
  let name: String
  let type: String
  let language: String
  let genres: [String]
  let status: String
  let image: Image
}

struct Image: Codable {
  let medium: String
  let original: String
}
