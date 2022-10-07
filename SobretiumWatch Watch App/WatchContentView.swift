//
//  WatchContentView.swift
//  SobretiumWatch Watch App
//
//  Created by Tarball on 10/6/22.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<SobrietyEntry>
    var body: some View {
        NavigationView {
            List {
                ForEach(entries) { entry in
                    Text(entry.name!)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
