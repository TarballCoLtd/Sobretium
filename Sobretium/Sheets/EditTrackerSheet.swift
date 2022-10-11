//
//  EditTrackerSheet.swift
//  Sobretium
//
//  Created by Tarball on 10/2/22.
//

import SwiftUI

struct EditTrackerSheet: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<SobrietyEntry>
    @AppStorage("stealth") var stealth: Bool = false
    @State var entry: SobrietyEntry
    @State var name: String
    @State var pickerDate: Date
    @State var subtitle: String
    @State var currentTheme: String
    @State var defaultEntry: Bool
    @State var defaultInfoAlert: Bool = false
    let initialTheme: Int32
    init(_ entry: SobrietyEntry) {
        self._entry = State(initialValue: entry)
        self._name = State(initialValue: entry.name!)
        self._pickerDate = State(initialValue: entry.startDate!)
        self._subtitle = State(initialValue: entry.subtitle ?? "")
        self._defaultEntry = State(initialValue: entry.defaultEntry)
        if entry.themeIndex > Theme.themes.count - 1 {
            self._currentTheme = State(initialValue: Theme.prideThemes[Int(entry.themeIndex) - Theme.themes.count].name)
        } else {
            self._currentTheme = State(initialValue: Theme.themes[Int(entry.themeIndex)].name)
        }
        initialTheme = entry.themeIndex
    }
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Name")
                    Divider()
                    TextField(stealth ? "Tracker name" : "Addiction name", text: $name)
                }
                VStack {
                    HStack {
                        Text("Start Date")
                        Spacer()
                    }
                    DatePicker("", selection: $pickerDate, displayedComponents: [.date, .hourAndMinute])
                }
                HStack {
                    Text("Subtitle")
                    Divider()
                    TextField("I've been \(name.count == 0 ? "..." : name.lowercased()) free for", text: $subtitle)
                }
                NavigationLink {
                    ThemePicker(entry)
                } label: {
                    HStack {
                        Text("Theme")
                        Spacer()
                        Text(currentTheme)
                    }
                    .onAppear {
                        if entry.themeIndex > Theme.themes.count - 1 {
                            currentTheme = Theme.prideThemes[Int(entry.themeIndex) - Theme.themes.count].name
                        } else {
                            currentTheme = Theme.themes[Int(entry.themeIndex)].name
                        }
                    }
                }
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
                        entry.themeIndex = initialTheme
                        presentation.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(stealth ? "Edit Tracker" : "Edit Sobriety Tracker")
                        .fixedSize(horizontal: true, vertical: false)
                        .font(.headline)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        entry.name = name
                        entry.startDate = pickerDate
                        if subtitle == "" {
                            entry.subtitle = nil
                        } else {
                            entry.subtitle = subtitle
                        }
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
