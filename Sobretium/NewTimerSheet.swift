//
//  NewTimerSheet.swift
//  Sobretium
//
//  Created by Alyx Ferrari on 5/19/22.
//

import SwiftUI

struct NewTimerSheet: View {
    @Environment(\.presentationMode) var presentation
    @State var startDate = Date()
    @State var name = ""
    @Binding var list: SobrietyList
    @Binding var presented: Bool
    init(_ list: Binding<SobrietyList>, _ presented: Binding<Bool>) {
        self._list = list
        self._presented = presented
    }
    var body: some View {
        NavigationView {
            List {
                HStack {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                }
                TextField("Addiction name", text: $name)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentation.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        let entry = SobrietyEntry(name: name, rings: SobrietyRings(false, startDate, false))
                        list.entries.append(entry)
                        presentation.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
