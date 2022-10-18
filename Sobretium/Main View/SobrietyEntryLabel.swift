//
//  SobrietyEntryLabel.swift
//  Sobretium
//
//  Created by Tarball on 10/12/22.
//

import SwiftUI

struct SobrietyEntryLabel: View {
    @State var entry: SobrietyEntry
    init(_ entry: SobrietyEntry) {
        self._entry = State(initialValue: entry)
    }
    var body: some View {
        HStack {
            Text(entry.name!)
            Spacer()
            Text(entry.startDate!.daysAgoString)
                .frame(minWidth: 0, minHeight: 0)
                .padding(5)
                .overlay {
                    Capsule()
                        .stroke(Color.accentColor, lineWidth: 1)
                }
        }
    }
}

extension Date {
    var daysAgoString: String {
        return "\(String(Int(self.daysAgoAbs))) \(Int(self.daysAgoAbs) == 1 ? "Day" : "Days")"
    }
}
