//
//  WatchRing.swift
//  SobretiumWatch Watch App
//
//  Created by Tarball on 10/6/22.
//

// yes, i know you can share files between targets
// i just didnt want to clutter it up with a bunch of compiler directives
// personal preference i suppose

import SwiftUI

struct Ring: View {
    public static let lineWidth: CGFloat = 5.5
    @State var color: Color?
    @Binding var progress: Float
    @State var divisor: Float
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(lineWidth: Ring.lineWidth)
                    .opacity(0.4)
                    .foregroundColor(color)
                Circle()
                    .trim(from: 0.0, to: CGFloat(progress / divisor))
                    .stroke(style: StrokeStyle(lineWidth: Ring.lineWidth, lineCap: .round))
                    .foregroundColor(color)
                    .rotationEffect(.degrees(270.0))
            }
        }
    }
}
