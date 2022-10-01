//
//  RingView.swift
//  Sobretium
//
//  Created by Alyx Ferrari on 9/14/22.
//

import SwiftUI

struct RingView: View {
    @AppStorage("ringType") var ringType: Bool = false
    @State var entry: SobrietyEntry
    init(_ entry: SobrietyEntry) {
        self.entry = entry
    }
    var body: some View {
        VStack {
            Text(entry.name!)
                .padding(.bottom)
            SobrietyRings(false, entry.startDate!, ringType)
        }
    }
}
