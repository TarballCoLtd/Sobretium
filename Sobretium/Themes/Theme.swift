//
//  Theme.swift
//  Sobretium
//
//  Created by Tarball on 10/2/22.
//

import SwiftUI

class Theme: Identifiable, Equatable {
    public static let themes: [Theme] = [
        Theme(
            Color.teal, Color.red, Color.purple, Color.pink, Color.orange,
            Color.white, Color.white, Color.white, Color.white, Color.white,
            "Sobretium"
        ),
        Theme(
            Color(0xf0c22c), Color(0xee9e20), Color(0xe65104), Color(0xae3204), Color(0x751a01),
            Color.black, Color.black, Color.white, Color.white, Color.white,
            "Autumn"
        ),
        Theme(
            Color(0xfffeed), Color(0xcdd873), Color(0xd03b3b), Color(0x901a1a), Color(0x28543c),
            Color.black, Color.black, Color.white, Color.white, Color.white,
            "Christmas"
        ),
        Theme(
            Color(0xcdad75), Color(0x965336), Color(0x7e2c2e), Color(0x78021f), Color(0x450019),
            Color.black, Color.white, Color.white, Color.white, Color.white,
            "Ruby"
        ),
        Theme(
            Color(0x2796ff), Color(0x29589f), Color(0x292c59), Color(0x17151d), Color.black,
            Color.black, Color.white, Color.white, Color.white, Color.white,
            "Starry Night"
        ),
        Theme(
            Color(0xffe558), Color(0xffae2f), Color(0xff5a00), Color(0x832e01), Color.black,
            Color.black, Color.black, Color.white, Color.white, Color.white,
            "Halloween"
        ),
        Theme(
            Color(0x6272a4), Color(0x50fa7b), Color(0xff79c6), Color(0xbd93f9), Color(0x44475a),
            Color.white, Color.black, Color.black, Color.white, Color.white,
            "Dracula"
        ),
    ]
    public static let prideThemes: [Theme] = [
        Theme(
            Color(0xe40303), Color(0xff8c00), Color(0x008026), Color(0x004dff), Color(0x750787),
            Color.white, Color.black, Color.white, Color.white, Color.white,
            "Rainbow"
        ),
        Theme(
            Color(0xd52d00), Color(0xff9a56), Color.white, Color(0xd362a4), Color(0xa30262),
            Color.white, Color.white, Color.black, Color.white, Color.white,
            "Lesbian Pride"
        ),
        Theme(
            Color(0x26ceaa), Color(0x98e8c1), Color.white, Color(0x7bade2), Color(0x5049cc),
            Color.black, Color.black, Color.black, Color.white, Color.white,
            "Gay Pride"
        ),
        Theme(
            Color(0xd60270), Color(0x9b4f96), Color(0x9b4f96), Color(0x9b4f96), Color(0x0038a8),
            Color.white, Color.white, Color.white, Color.white, Color.white,
            "Bisexual Pride"
        ),
        Theme(
            Color.teal, Color(0xf5a9b8), Color.white, Color(0xf5a9b8), Color.teal,
            Color.black, Color.black, Color.black, Color.black, Color.black,
            "Trans Pride"
        ),
    ]
    
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.name == rhs.name
    }
    
    public var color1: Color
    public var color2: Color
    public var color3: Color
    public var color4: Color
    public var color5: Color
    public var textColor1: Color
    public var textColor2: Color
    public var textColor3: Color
    public var textColor4: Color
    public var textColor5: Color
    public var name: String
    init(_ color1: Color, _ color2: Color, _ color3: Color, _ color4: Color, _ color5: Color, _ textColor1: Color, _ textColor2: Color, _ textColor3: Color, _ textColor4: Color, _ textColor5: Color, _ name: String) {
        self.color1 = color1
        self.color2 = color2
        self.color3 = color3
        self.color4 = color4
        self.color5 = color5
        self.textColor1 = textColor1
        self.textColor2 = textColor2
        self.textColor3 = textColor3
        self.textColor4 = textColor4
        self.textColor5 = textColor5
        self.name = name
    }
}

extension Color {
    init(_ hex: UInt) { // yeah yeah, there's inconsistent whitespace - i normally hate it too but i thought it looked nice here
        self.init(
            .sRGB,
            red:   Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue:  Double((hex >> 00) & 0xff) / 255,
            opacity: 255
        )
    }
}
