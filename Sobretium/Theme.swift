//
//  Theme.swift
//  Sobretium
//
//  Created by Tarball on 10/2/22.
//

import SwiftUI

class Theme {
    public static let themes: [Theme] = [
        Theme(
            Color.teal, Color.red, Color.purple, Color.pink, Color.orange,
            Color.black, Color.black, Color.black, Color.black, Color.black,
            "Sobretium"
        ),
    ]
    
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
