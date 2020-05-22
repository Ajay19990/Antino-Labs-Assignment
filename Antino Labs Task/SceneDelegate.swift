//
//  SceneDelegate.swift
//  Antino Labs Task
//
//  Created by Ajay Choudhary on 22/05/20.
//  Copyright © 2020 Ajay Choudhary. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    let nc = UINavigationController(rootViewController: PeopleVC())
    window?.rootViewController = nc
    window?.makeKeyAndVisible()
  }

}

