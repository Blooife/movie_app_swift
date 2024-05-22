//
//  movie_app_swiftApp.swift
//  Shared
//
//  Created by Alex on 27.04.2024.
//

import SwiftUI
import Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct movie_app_swiftApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var authManager = AuthManager()

  var body: some Scene {
    WindowGroup {
        Wrapper()
            .environmentObject(authManager)
    }
  }
}

    

  
