//
//  AboutView.swift
//  Sobretium
//
//  Created by Alyx Ferrari on 9/29/22.
//

import SwiftUI
import Foundation

struct AboutView: View {
    var body: some View {
        VStack {
            Text("Sobretium")
                .font(.title)
            Text("by Alyx Ferrari")
                .font(.subheadline)
            Text("")
            Text("Version 0.1 build 1")
            Spacer()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
