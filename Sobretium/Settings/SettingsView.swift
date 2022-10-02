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
    var body: some View {
        List {
            Toggle("Stealth Mode", isOn: $stealth)
            Toggle("Performance Mode", isOn: $performance)
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
