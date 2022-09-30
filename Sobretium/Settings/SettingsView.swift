//
//  SettingsView.swift
//  Sobretium
//
//  Created by Alyx Ferrari on 9/15/22.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("stealth") var stealth: Bool = false
    @AppStorage("performance") var performance: Bool = false
    var body: some View {
        List {
            Toggle("Stealth Mode", isOn: $stealth)
            Toggle("Performance Mode", isOn: $performance)
            NavigationLink {
                AboutView()
            } label: {
                Text("About")
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Settings")
                    .font(.headline)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
