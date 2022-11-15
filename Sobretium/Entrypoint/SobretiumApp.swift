//
//  SobretiumApp.swift
//  Sobretium
//
//  Created by Tarball on 5/19/22.
//

import SwiftUI
import WhatsNewKit

@main
struct SobretiumApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.whatsNew, WhatsNewEnvironment(versionStore: UserDefaultsWhatsNewVersionStore(), whatsNewCollection: self))
        }
    }
}

extension SobretiumApp: WhatsNewCollectionProvider {
    var whatsNewCollection: WhatsNewCollection {
        WhatsNew(
            version: "1.0.6",
            title: .init(text: .init("What's New in " + AttributedString("Sobretium", attributes: .foregroundColor(.red)))),
        )
    }
}
