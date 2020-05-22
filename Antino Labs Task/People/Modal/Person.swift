//
//  Person.swift
//  Antino Labs Task
//
//  Created by Ajay Choudhary on 23/05/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

struct Person: Codable {
  let profileUrl: String
  let name: String
  let age: String
  let location: String
  let details: [String]
  let bodyType: String
  let userDesire: String
  
  enum CodingKeys: String, CodingKey {
    case profileUrl = "url"
    case name
    case age
    case location
    case details = "Details"
    case bodyType
    case userDesire
  }
}
