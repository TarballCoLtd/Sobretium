//
//  SettingsView.swift
//  Sobretium
//
//  Created by Tarball on 9/15/22.
//

import SwiftUI
import LocalAuthentication
import WhatsNewKit

struct SettingsView: View {
    @AppStorage("stealth") var stealth: Bool = false
    @AppStorage("performance") var performance: Bool = false
    @AppStorage("ringType") var ringType: Bool = false
    @AppStorage("biometry") var biometry: Bool = false
    @Environment(\.whatsNew) var whatsNewEnvironment
    @State var biometryToggleLabel: String = "Enable \(SettingsView.authenticationType())"
    @State var biometryMissingAlert: Bool = false
    @State var biometryUnsupportedAlert: Bool = false
    @State var stealthInfoAlert: Bool = false
    @State var performanceInfoAlert: Bool = false
    @State var whatsNew: WhatsNew?
    var body: some View {
        List {
            Section {
                Toggle(isOn: $stealth) {
                    HStack {
                        Text("Stealth Mode")
                        Image(systemName: "info.circle")
                            .foregroundColor(.accentColor)
                            .onTapGesture {
                                stealthInfoAlert = true
                            }
                            .alert("Stealth mode removes most indicators that this app is for tracking sobriety.", isPresented: $stealthInfoAlert) {
                                Button("OK", role: .cancel) {}
                            }
                        Spacer()
                    }
                }
                Toggle(isOn: $performance) {
                    HStack {
                        Text("Performance Mode")
                        Image(systemName: "info.circle")
                            .foregroundColor(.accentColor)
                            .onTapGesture {
                                performanceInfoAlert = true
                            }
                            .alert("Performance mode removes shadows and some graphical effects to reduce battery usage.", isPresented: $performanceInfoAlert) {
                                Button("OK", role: .cancel) {}
                            }
                        Spacer()
                    }
                }
                Toggle(biometryToggleLabel, isOn: $biometry)
                    .onChange(of: biometry, perform: authenticate)
                    .alert("\(SettingsView.authenticationType()) is not set up on your device.", isPresented: $biometryMissingAlert) {
                        Button("OK", role: .cancel) {}
                    }
                    .alert("Your device does not support biometric authentication.", isPresented: $biometryUnsupportedAlert) {
                        Button("OK", role: .cancel) {}
                    }
            }
            Section {
                Button("Present 'What's New' Sheet") {
                    whatsNew = whatsNewEnvironment.whatsNewCollection.last!
                }
                .sheet(whatsNew: $whatsNew)
                NavigationLink {
                    AboutView()
                } label: {
                    Text("About")
                }
                NavigationLink {
                    DonateView()
                } label: {
                    Text("Donate")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.headline)
            }
        }
    }
    static func authenticationType() -> String {
        let context = LAContext()
        var error: NSError?
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error {
            print(error)
        }
        if context.biometryType == .touchID {
            return "Touch ID"
        }
        if context.biometryType == .faceID {
            return "Face ID"
        }
        return "Biometric Authentication"
    }
    func authenticate(value: Bool) {
        if biometry {
            let context = LAContext()
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Touch ID access is needed for biometric authentication."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if !success {
                        biometry = false
                    }
                }
            } else {
                biometry = false
                if SettingsView.authenticationType() == "Biometric Authentication" {
                    biometryUnsupportedAlert = true
                } else {
                    biometryMissingAlert = true
                }
            }
            if let error = error {
                print(error)
            }
        }
    }
}
