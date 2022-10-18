//
//  ThemePicker.swift
//  Sobretium
//
//  Created by Tarball on 10/2/22.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var themeIndex: Int
    init(_ themeIndex: Binding<Int>) {
        self._themeIndex = themeIndex
        /*
        if entry.themeIndex > Theme.themes.count - 1 {
            selectedTheme = Theme.prideThemes[Int(entry.themeIndex) - Theme.themes.count].name
        } else {
            selectedTheme = Theme.themes[Int(entry.themeIndex)].name
        }
         */
    }
    var body: some View {
        List {
            Section {
                ForEach(Theme.themes) { theme in
                    Button {
                        if let index = Theme.themes.firstIndex(of: theme) {
                            themeIndex = index
                        }
                    } label: {
                        SelectionCell($themeIndex, theme)
                    }
                }
            }
            Section {
                ForEach(Theme.prideThemes) { theme in
                    Button {
                        if let index = Theme.prideThemes.firstIndex(of: theme) {
                            themeIndex = index + Theme.themes.count
                        }
                    } label: {
                        SelectionCellPride($themeIndex, theme)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Theme Editor")
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.headline)
            }
        }
    }
}

struct SelectionCell: View {
    @Binding var themeIndex: Int
    let index: Int
    let theme: Theme
    init(_ themeIndex: Binding<Int>, _ theme: Theme) {
        self._themeIndex = themeIndex
        self.theme = theme
        if let index = Theme.themes.firstIndex(of: theme) {
            self.index = index
        } else {
            self.index = -1
        }
    }
    var body: some View {
        HStack {
            Image(systemName: themeIndex == index ? "checkmark.circle" : "circle")
                .foregroundColor(.accentColor)
            Text(theme.name)
            Spacer()
            ThemeSample(theme)
        }
        .contentShape(Rectangle())
    }
}

struct SelectionCellPride: View {
    @Binding var themeIndex: Int
    let index: Int
    let theme: Theme
    init(_ themeIndex: Binding<Int>, _ theme: Theme) {
        self._themeIndex = themeIndex
        self.theme = theme
        if let index = Theme.prideThemes.firstIndex(of: theme) {
            self.index = index
        } else {
            self.index = -1
        }
    }
    var body: some View {
        HStack {
            Image(systemName: themeIndex == index + Theme.themes.count ? "checkmark.circle" : "circle")
                .foregroundColor(.accentColor)
            Text(theme.name)
            Spacer()
            ThemeSample(theme)
        }
        .contentShape(Rectangle())
    }
}
