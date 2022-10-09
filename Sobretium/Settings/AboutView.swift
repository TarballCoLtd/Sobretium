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
            Image("SobretiumIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(25)
                .shadow(radius: 15)
            Text("Sobretium")
                .font(.largeTitle)
            Text("[so-BREE-shee-um]")
                .font(.subheadline)
            Text("by Alyx Ferrari")
                .font(.subheadline)
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
