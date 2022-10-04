//
//  SettingsView.swift
//  Sobretium
//
//  Created by Tarball on 9/15/22.
//

import SwiftUI
import LocalAuthentication

struct SettingsView: View {
    @AppStorage("stealth") var stealth: Bool = false
    @AppStorage("performance") var performance: Bool = false
    @AppStorage("ringType") var ringType: Bool = false
    @AppStorage("biometry") var biometry: Bool = false
    @State var biometryToggleLabel: String = "Enable \(SettingsView.authenticationType())"
    @State var biometryMissingAlert: Bool = false
    @State var biometryUnsupportedAlert: Bool = false
    @State var stealthInfoAlert: Bool = false
    @State var performanceInfoAlert: Bool = false
    var body: some View {
        List {
            Toggle(isOn: $stealth) {
                HStack {
                    Text("Stealth Mode")
                    Button {
                        stealthInfoAlert = true
                    } label: {
                        Image(systemName: "info.circle")
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
                    Button {
                        performanceInfoAlert = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .alert("Performance mode removes shadows and graphical effects to reduce battery usage.", isPresented: $performanceInfoAlert) {
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
            NavigationLink {
                AboutView()
            } label: {
                Text("About")
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
