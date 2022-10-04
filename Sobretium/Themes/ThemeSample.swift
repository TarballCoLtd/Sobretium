//
//  ThemeSample.swift
//  Sobretium
//
//  Created by Tarball on 10/2/22.
//

import SwiftUI

struct ThemeSample: View {
    @State var theme: Theme
    init(_ theme: Theme) {
        self._theme = State(initialValue: theme)
    }
    var body: some View {
        HStack {
            Circle()
                .fill(theme.color1)
                .overlay {
                    Circle().stroke(.gray, lineWidth: 1)
                }
                .frame(maxWidth: 15, maxHeight: 15)
            Circle()
                .fill(theme.color2)
                .overlay {
                    Circle().stroke(.gray, lineWidth: 1)
                }
                .frame(maxWidth: 15, maxHeight: 15)
            Circle()
                .fill(theme.color3)
                .overlay {
                    Circle().stroke(.gray, lineWidth: 1)
                }
                .frame(maxWidth: 15, maxHeight: 15)
            Circle()
                .fill(theme.color4)
                .overlay {
                    Circle().stroke(.gray, lineWidth: 1)
                }
                .frame(maxWidth: 15, maxHeight: 15)
            Circle()
                .fill(theme.color5)
                .overlay {
                    Circle().stroke(.gray, lineWidth: 1)
                }
                .frame(maxWidth: 15, maxHeight: 15)
        }
    }
}
