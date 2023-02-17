//
//  SobretiumWatchApp.swift
//  SobretiumWatch Watch App
//
//  Created by Tarball on 10/6/22.
//

import SwiftUI

@main
struct SobretiumWatchApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
