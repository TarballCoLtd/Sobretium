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
                if entries.count == 0 {
                    VStack {
                        Text("No Saved Trackers")
                            .font(.title)
                        Text("Open the app on your iPhone to get started")
                    }
                } else {
                    List {
                        ForEach(entries) { entry in
                            if entry.startDate != nil && entry.name != nil {
                                NavigationLink(tag: entry.name ?? UUID().uuidString, selection: $linkSelection) {
                                    SobrietyRings(entry)
                                        .padding(.top)
                                } label: {
                                    Text(entry.name ?? "Error")
                                }
                            }
                        }
                    }
                    .navigationTitle("Sobretium")
                }
            }
        }
        .onAppear(perform: showView)
    }
    func showView() {
        for entry in entries {
            if entry.defaultEntry {
                linkSelection = entry.name ?? UUID().uuidString
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
