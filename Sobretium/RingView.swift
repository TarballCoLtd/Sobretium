//
//  RingView.swift
//  Sobretium
//
//  Created by Tarball on 9/14/22.
//

import SwiftUI

struct RingView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    @AppStorage("ringType") var ringType: Bool = false
    @State var entry: SobrietyEntry
    @State var editTrackerSheetPresented: Bool = false
    init(_ entry: SobrietyEntry) {
        self._entry = State(initialValue: entry)
    }
    var body: some View {
        VStack {
            Text(entry.subtitle ?? "I've been \(entry.name!.lowercased()) free for")
            SobrietyRings(false, entry.startDate!, ringType)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(entry.name!)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.headline)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    presentation.wrappedValue.dismiss()
                    editTrackerSheetPresented = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .sheet(isPresented: $editTrackerSheetPresented) {
            EditTrackerSheet(entry)
        }
    }
}
