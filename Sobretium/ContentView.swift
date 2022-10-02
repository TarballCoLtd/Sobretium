//
//  ContentView.swift
//  Sobretium
//
//  Created by Tarball on 4/27/22.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @AppStorage("stealth") var stealth: Bool = false
    @AppStorage("biometry") var biometry: Bool = false
    @State var addTrackerSheetPresented: Bool = false
    @FetchRequest(sortDescriptors: []) var entries: FetchedResults<SobrietyEntry>
    @State var deletionCandidate: SobrietyEntry?
    @State var deletionAlertPresented: Bool = false
    @Environment(\.managedObjectContext) var moc
    @State var authenticated: Bool = false
    var body: some View {
        NavigationView {
            if authenticated {
                VStack {
                    if entries.count == 0 {
                        Text("No Saved Trackers")
                            .font(.title)
                        Text("Press the + button to get started")
                    } else {
                        List {
                            Section(header: Text(stealth ? "Trackers" : "Sobriety Trackers")) {
                                ForEach(entries) { entry in
                                    if entry.startDate != nil && entry.name != nil {
                                        NavigationLink {
                                            RingView(entry)
                                        } label: {
                                            Text(entry.name!)
                                        }
                                        .swipeActions {
                                            Button {
                                                
                                            } label: {
                                                Image(systemName: "trash")
                                                    .resizable()
                                                    .scaledToFit()
                                            }
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
            }
        }
        .onAppear(perform: authenticate)
    }
    func authenticate() {
        if !biometry {
            withAnimation {
                authenticated = true
            }
            return
        }
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Touch ID access is needed for biometric authentication."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    withAnimation {
                        authenticated = true
                    }
                } else {
                    authenticate() // TODO: replace with PIN code
                }
            }
        } else {
            biometry = false
            withAnimation {
                authenticated = true
            }
        }
        if let error = error {
            print(error)
        }
    }
    func deleteAddiction(addiction: SobrietyEntry) {
        deletionCandidate = addiction
        deletionAlertPresented = true
    }
}
