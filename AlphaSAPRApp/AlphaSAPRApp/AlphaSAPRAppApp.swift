//
//  AlphaSAPRAppApp.swift
//  AlphaSAPRApp
//
//  Created by Alex Hernandez on 3/23/21.
//

import SwiftUI
import Firebase

@main
struct AlphaSAPRAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject private var locationData = LocationData()
    @StateObject private var timeToLeaveSettings = TimeToLeaveSettings()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationData)
                .environmentObject(timeToLeaveSettings)
        }
    }
}
