//
//  NewTimerSheet.swift
//  Sobretium
//
//  Created by Tarball on 5/19/22.
//

import SwiftUI

struct NewTimerSheet: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    @AppStorage("stealth") var stealth: Bool = false
    @State var startDate = Date()
    @State var name = ""
    @State var defaultEntry: Bool = false
    @State var defaultInfoAlert: Bool = false
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<SobrietyEntry>
    var body: some View {
        NavigationView {
            List {
                DatePicker("Start Date", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                TextField(stealth ? "Tracker name" : "Addiction name", text: $name)
                Toggle(isOn: $defaultEntry) {
                    HStack {
                        Text(stealth ? "Default Tracker" : "Default Sobriety Tracker")
                        Image(systemName: "info.circle")
                            .foregroundColor(.accentColor)
                            .onTapGesture {
                                defaultInfoAlert = true
                            }
                            .alert("Your default tracker will automatically open when you open the app.", isPresented: $defaultInfoAlert) {
                                Button("OK", role: .cancel) {}
                            }
                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentation.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(stealth ? "Add Tracker" : "Add Sobriety Tracker")
                        .fixedSize(horizontal: true, vertical: false)
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        let entry = SobrietyEntry(context: moc)
                        entry.id = UUID()
                        entry.name = name
                        entry.startDate = startDate
                        if defaultEntry {
                            for entry in entries {
                                entry.defaultEntry = false
                            }
                        }
                        entry.defaultEntry = defaultEntry
                        try? moc.save()
                        presentation.wrappedValue.dismiss()
                    }
                    .disabled(name.count == 0)
                }
            }
        }
    }
}
