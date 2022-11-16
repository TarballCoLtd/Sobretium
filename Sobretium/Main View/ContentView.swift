//
//  ContentView.swift
//  Sobretium
//
//  Created by Tarball on 4/27/22.
//

import SwiftUI
import LocalAuthentication
import WhatsNewKit

struct ContentView: View {
    @AppStorage("stealth") var stealth: Bool = false
    @AppStorage("biometry") var biometry: Bool = false
    @AppStorage("launchCount") var launchCount: Int = 0
    @Environment(\.managedObjectContext) var moc
    @Environment(\.whatsNew) var whatsNewEnvironment
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<SobrietyEntry>
    @State var addTrackerSheetPresented: Bool = false
    @State var editTrackerSheetPresented: Bool = false
    @State var deletionCandidate: SobrietyEntry?
    @State var deletionAlertPresented: Bool = false
    @State var authenticated: Bool = false
    @State var linkSelection: String?
    #if DEBUG
    @State var whatsNew: WhatsNew?
    #endif
    var updateListenerTask: Task<Void, Error>? = nil
    init() {
        updateListenerTask = listenForTransactions()
    }
    var body: some View {
        NavigationView {
            if authenticated {
                Group {
                    if entries.count == 0 {
                        VStack {
                            Text("No Saved Trackers")
                                .font(.title)
                            Text("Press the + button to get started")
                        }
                    } else {
                        List {
                            #if DEBUG
                            Section(header: Text("Debug")) {
                                Button("Present 'What's New' Sheet") {
                                    whatsNew = whatsNewEnvironment.whatsNewCollection.last!
                                }
                                .sheet(whatsNew: $whatsNew)
                            }
                            #endif
                            Section(header: Text(stealth ? "Trackers" : "Sobriety Trackers")) {
                                ForEach(entries) { entry in
                                    if entry.startDate != nil && entry.name != nil {
                                        NavigationLink(tag: entry.name ?? UUID().uuidString, selection: $linkSelection) {
                                            RingView(entry)
                                        } label: {
                                            SobrietyEntryLabel(entry)
                                        }
                                        .swipeActions {
                                            Button {
                                                deleteAddiction(entry)
                                            } label: {
                                                Image(systemName: "trash")
                                                    .resizable()
                                                    .scaledToFit()
                                            }
                                            .tint(.red)
                                            Button {
                                                editTrackerSheetPresented = true
                                            } label: {
                                                Image(systemName: "square.and.pencil")
                                                    .resizable()
                                                    .scaledToFit()
                                            }
                                            .tint(.yellow)
                                        }
                                        .sheet(isPresented: $editTrackerSheetPresented) {
                                            EditTrackerSheet(entry)
                                        }
                                    }
                                }
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
                            .fixedSize(horizontal: true, vertical: false)
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
                    NewTimerSheet()
                }
                .alert("Are you sure you want to delete this tracker?", isPresented: $deletionAlertPresented) {
                    Button("Cancel", role: .cancel) {}
                    Button("Yes", role: .destructive) {
                        if let deletionCandidate = deletionCandidate {
                            moc.delete(deletionCandidate)
                            try? moc.save()
                        }
                        deletionCandidate = nil
                        deletionAlertPresented = false
                    }
                }
                .whatsNewSheet()
            }
        }
        .onAppear(perform: authenticate)
    }
    func authenticate() {
        if !biometry {
            showView()
            return
        }
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Touch ID access is needed for biometric authentication."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    showView()
                } else {
                    authenticate()
                }
            }
        } else {
            biometry = false
            showView()
        }
        if let error = error {
            print(error)
        }
    }
    func showView() {
        launchCount += 1
        for entry in entries {
            if entry.defaultEntry {
                linkSelection = entry.name ?? UUID().uuidString
                authenticated = true
                return
            }
        }
        withAnimation {
            authenticated = true
        }
    }
    func deleteAddiction(_ addiction: SobrietyEntry) {
        deletionCandidate = addiction
        deletionAlertPresented = true
    }
    func listenForTransactions() -> Task<Void, Error> { // ripped from Apple's demo lol
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try DonateView.checkVerified(result)
                    await transaction.finish()
                } catch {
                    print(error)
                }
            }
        }
    }
}
