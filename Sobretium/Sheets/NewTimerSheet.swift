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
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<SobrietyEntry>
    var body: some View {
        NavigationView {
            List {
                DatePicker("Start Date", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                TextField(stealth ? "Tracker name" : "Addiction name", text: $name)
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
                        try? moc.save()
                        presentation.wrappedValue.dismiss()
                    }
                    .disabled(name.count == 0)
                }
            }
        }
    }
}
