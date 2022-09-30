//
//  ContentView.swift
//  Sobretium
//
//  Created by Alyx Ferrari on 4/27/22.
//
import Time
import SwiftUI

struct ContentView: View {
    @AppStorage("stealth") var stealth: Bool = false
    @State var addTrackerSheetPresented: Bool = false
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<SobrietyEntry>
    @State var deletionCandidate: IndexSet?
    @State var deletionAlertPresented: Bool = false
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        NavigationView {
            VStack {
                if entries.count == 0 {
                    Text("No Saved Trackers")
                        .font(.title)
                    Text("Press the + button to get started")
                } else {
                    List {
                        Section(header: Text(stealth ? "Trackers" : "Sobriety Trackers")) {
                            ForEach(entries) { entry in
                                NavigationLink {
                                    SobrietyRings(false, entry.startDate!, false)
                                } label: {
                                    HStack {
                                        Text(entry.name!)
                                        Spacer()
                                        SobrietyRings(true, entry.startDate!, false)
                                            //.frame(maxWidth: 60, maxHeight: 60)
                                    }
                                }
                            }
                            .onDelete(perform: deleteAddiction)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(stealth ? "" : "Sobretium")
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addTrackerSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            .sheet(isPresented: $addTrackerSheetPresented) {
                NewTimerSheet($addTrackerSheetPresented)
            }
            .alert("Are you sure you want to delete this tracker?", isPresented: $deletionAlertPresented) {
                Button("Yes", role: .destructive) {
                    if let deletionCandidate = deletionCandidate {
                        for index in deletionCandidate {
                            moc.delete(entries[index])
                        }
                        try? moc.save()
                    }
                    deletionCandidate = nil
                    deletionAlertPresented = false
                }
            }
        }
    }
    func deleteAddiction(at offset: IndexSet) {
        deletionCandidate = offset
        deletionAlertPresented = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
