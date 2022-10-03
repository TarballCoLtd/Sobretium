//
//  AboutView.swift
//  Sobretium
//
//  Created by Tarball on 9/29/22.
//

import SwiftUI
import Foundation

struct AboutView: View {
    var body: some View {
        VStack {
            Text("Sobretium")
                .font(.largeTitle)
            Text("[so-BREE-shee-um]")
                .font(.subheadline)
            Text("by Alyx Ferrari")
                .font(.subheadline)
            Text("")
            Text("Version 0.4.1 build 71")
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("About")
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
}
