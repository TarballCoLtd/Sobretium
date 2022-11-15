//
//  SobrietyEntryLabel.swift
//  Sobretium
//
//  Created by Tarball on 10/12/22.
//

import SwiftUI

struct SobrietyEntryLabel: View {
    @ObservedObject var entry: SobrietyEntry
    let gradient = LinearGradient(gradient: Gradient(colors: [.accentColor, .cyan, .accentColor]), startPoint: .leading, endPoint: .trailing)
    init(_ entry: SobrietyEntry) {
        self._entry = ObservedObject(initialValue: entry)
    }
    var body: some View {
        HStack {
            Text(entry.name!)
            Spacer()
            Text(entry.startDate!.daysAgoString)
                .frame(minWidth: 0, minHeight: 0)
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
                .overlay {
                    Capsule()
                        .stroke(gradient, lineWidth: 1)
                }
        }
    }
}

extension Date {
    var daysAgoString: String {
        return "\(String(Int(self.daysAgoAbs))) \(Int(self.daysAgoAbs) == 1 ? "Day" : "Days")"
    }
}
