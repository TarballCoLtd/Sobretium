//
//  ContentView.swift
//  Sobretium
//
//  Created by Alyx Ferrari on 4/27/22.
//
import Time
import SwiftUI

struct ContentView: View {
    @State var date: Date = Date(timeIntervalSince1970: 1641000000)
    @State var date2: Date = Date(timeIntervalSince1970: 1631000000)
    @State var type: Bool = false
    @State var isPresented: Bool = false
    @State var list: [SobrietyEntry] = []
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if list.count == 0 {
                        Text("No Saved Trackers")
                    }
                    ForEach(list) { entry in
                        NavigationLink {
                            entry.rings
                        } label: {
                            Text(entry.name)
                        }
                    }
                    .onDelete(perform: deleteAddiction)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isPresented = true
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                        }
                    }
                }
                .sheet(isPresented: $isPresented) {
                    NewTimerSheet($list, $isPresented)
                }
                List {
                    // settings
                }
            }
        }
    }
    func deleteAddiction(at offset: IndexSet) {
        list.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
