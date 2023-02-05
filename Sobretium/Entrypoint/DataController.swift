//
//  DataController.swift
//  Sobretium
//
//  Created by Tarball on 9/30/22.
//

import CoreData

class DataController: ObservableObject {
    let container = NSPersistentCloudKitContainer(name: "SobrietyEntry")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("core data made a booboo: \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
