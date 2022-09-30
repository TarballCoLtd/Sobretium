//
//  SobretiumApp.swift
//  Sobretium
//
//  Created by Alyx Ferrari on 5/19/22.
//

import SwiftUI

@main
struct SobretiumApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
