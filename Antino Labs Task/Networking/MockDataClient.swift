//
//  MockDataClient.swift
//  Antino Labs Task
//
//  Created by Ajay Choudhary on 23/05/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import UIKit

class MockDataClient {
  
  static let placeholder = UIImage(named: "placeholder")!
  
  class func fetchPersonData(completion: @escaping ([Person], ErrorMessage?) -> Void) {
    let urlString = "http://demo8716682.mockable.io/cardData"
    
    guard let url = URL(string: urlString) else {
      completion([], .invalidRequest)
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if error != nil {
        completion([], .unableToComplete)
        return
      }
      
      guard let data = data else {
        completion([], .invalidData)
        return
      }
      
      do {
        let responseObject = try JSONDecoder().decode([Person].self, from: data)
        completion(responseObject, nil)
      } catch {
        completion([], .invalidResponse)
      }
    }
    task.resume()
  }
  
  class func fetchProfileImage(urlString: String, completion: @escaping (UIImage, Error?) -> Void) {
    guard let url = URL(string: urlString) else { return }
    
    if let imageFromCache = imageCache[urlString] {
      completion(imageFromCache, nil)
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(placeholder, error)
        return
      }
      
      guard let data = data else {
        completion(placeholder, error)
        return
      }
      
      let image = UIImage(data: data)
      imageCache[urlString] = image
      completion(image ?? placeholder, nil)
    }
    task.resume()
  }
  
}

var imageCache = [String: UIImage]()
