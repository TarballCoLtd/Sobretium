//
//  FitnessRings.swift
//  FitnessRingsDemo
//
//  Created by Tarball on 4/27/22.
//

import SwiftUI

struct AppIconRings: View {
    @State var seconds: Float = 37
    @State var minutes: Float = 17
    @State var hours: Float = 51
    @State var secondsText: String = ""
    @State var minutesText: String = ""
    @State var hoursText: String = ""
    @State var type: Bool = false
    var body: some View {
        VStack {
            Spacer()
            GeometryReader { geometry in
                ZStack {
                    Ring(color: Color.teal, progress: $seconds, divisor: 60, type: $type, text: $secondsText, tiny: false)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 10.0) + 120.0), height: geometry.size.height - ((Ring.lineWidth * 10.0) + 120.0))
                    Ring(color: Color.red, progress: $minutes, divisor: 60, type: $type, text: $minutesText, tiny: false)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 8.0) + 90.0), height: geometry.size.height - ((Ring.lineWidth * 8.0) + 90.0))
                    Ring(color: Color.purple, progress: $hours, divisor: 24, type: $type, text: $hoursText, tiny: false)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 6.0) + 60.0), height: geometry.size.height - ((Ring.lineWidth * 6.0) + 60.0))
                }
                .frame(maxWidth: .infinity)
            }
            Spacer()
        }
    }
}
