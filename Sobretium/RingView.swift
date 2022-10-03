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
    @State var resetDateAlertPresented: Bool = false
    init(_ entry: SobrietyEntry) {
        self._entry = State(initialValue: entry)
    }
    var body: some View {
        VStack {
            Text(entry.subtitle ?? "I've been \(entry.name!.lowercased()) free for")
            SobrietyRings(false, entry, ringType)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(entry.name!)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.headline)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button {
                        resetDateAlertPresented = true
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                            .resizable()
                            .scaledToFit()
                    }
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
        }
        .sheet(isPresented: $editTrackerSheetPresented) {
            EditTrackerSheet(entry)
        }
        .alert("Are you sure you want to reset your sobriety start date to today?", isPresented: $resetDateAlertPresented) {
            Button("Cancel", role: .cancel) {}
            Button("Yes", role: .destructive) {
                entry.startDate = Date()
                try? moc.save()
            }
        }
    }
}
