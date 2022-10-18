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
    let gradient = LinearGradient(gradient: Gradient(colors: [.accentColor, .cyan, .accentColor]), startPoint: .leading, endPoint: .trailing)
    init(_ entry: SobrietyEntry) {
        self._entry = State(initialValue: entry)
    }
    var body: some View {
        VStack {
            Text(entry.subtitle ?? "I've been \(entry.name!.lowercased()) free for")
                .frame(minWidth: 0, minHeight: 0)
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
                .multilineTextAlignment(.center)
                .overlay {
                    Capsule()
                        .stroke(gradient, lineWidth: 1)
                }
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
                if entry.streaks != nil {
                    entry.streaks!.append(Date())
                }
                try? moc.save()
            }
        }
        .onAppear {
            entry.lastView = Date()
            try? moc.save()
        }
    }
}
