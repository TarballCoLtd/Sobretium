//
//  WatchContentView.swift
//  SobretiumWatch Watch App
//
//  Created by Tarball on 10/6/22.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<SobrietyEntry>
    @State var authenticated: Bool = false
    @State var linkSelection: String?
    var body: some View {
        NavigationView {
            if authenticated {
                List {
                    ForEach(entries) { entry in
                        if entry.startDate != nil && entry.name != nil {
                            NavigationLink(tag: entry.name!, selection: $linkSelection) {
                                SobrietyRings(entry)
                                    .padding(.top)
                            } label: {
                                Text(entry.name!)
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: showView)
    }
    func showView() {
        for entry in entries {
            if entry.defaultEntry {
                linkSelection = entry.name!
                authenticated = true
                return
            }
        }
        authenticated = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
