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
    @Environment(\.scenePhase) var phase
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
            version: "1.0.7",
            title: .init(text: .init("What's New in " + AttributedString("Sobretium", attributes: .foregroundColor(.red)))),
            features: [
                .init(
                    image: .init(systemName: "eye.slash", foregroundColor: .cyan),
                    title: "Privacy",
                    subtitle: "App content will be blurred while the app is shown in the App Switcher, similar to banking apps."
                ),
                .init(
                    image: .init(systemName: "sparkles", foregroundColor: .yellow),
                    title: "Extended tracker length support",
                    subtitle: "Trackers with a length of 365 days or greater are now supported."
                ),
                .init(
                    image: .init(systemName: "iphone", foregroundColor: .accentColor), // gray?
                    title: "'What's New' summaries",
                    subtitle: "That's this! Future app updates will ship with a summary of the changes introduced in the update."
                ),
                .init(
                    image: .init(systemName: "wand.and.stars.inverse", foregroundColor: .cyan),
                    title: "Bug Fixes",
                    subtitle: "In previous versions, length summaries for each tracker on the tracker list didn't update until the app reloaded. This has been fixed."
                ),
            ]
        )
    }
}

extension AttributeContainer {
    static func foregroundColor(_ color: Color) -> Self {
        var container = Self()
        container.foregroundColor = color
        return container
    }
}
