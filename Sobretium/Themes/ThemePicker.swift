//
//  ThemePicker.swift
//  Sobretium
//
//  Created by Tarball on 10/2/22.
//

import SwiftUI

struct ThemePicker: View {
    @State var entry: SobrietyEntry
    @State var selectedTheme: String
    init(_ entry: SobrietyEntry) {
        self._entry = State(initialValue: entry)
        selectedTheme = Theme.themes[Int(entry.themeIndex)].name
    }
    var body: some View {
        List {
            ForEach(Theme.themes) { theme in
                Button {
                    selectedTheme = theme.name
                    if let index = Theme.themes.firstIndex(of: theme) {
                        entry.themeIndex = Int32(index)
                    }
                } label: {
                    SelectionCell(theme, $selectedTheme)
                }
            }
        }
    }
}

struct SelectionCell: View {
    @State var theme: Theme
    @Binding var selectedTheme: String
    init(_ theme: Theme, _ selectedTheme: Binding<String>) {
        self._theme = State(initialValue: theme)
        self._selectedTheme = selectedTheme
    }
    var body: some View {
        HStack {
            Image(systemName: theme.name == selectedTheme ? "checkmark.circle" : "circle")
                .foregroundColor(.accentColor)
            Text(theme.name)
            Spacer()
            ThemeSample(theme)
        }
        .contentShape(Rectangle())
    }
}
