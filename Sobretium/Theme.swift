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
            Color(0xfffeed), Color(0xcdd873), Color(0xd03b3b), Color(0x901a1a), Color(0x28543c),
            Color.black, Color.black, Color.black, Color.white, Color.white,
            "Christmas"
        ),
        Theme(
            Color.teal, Color.pink, Color.white, Color.pink, Color.teal,
            Color.black, Color.black, Color.black, Color.white, Color.white,
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
