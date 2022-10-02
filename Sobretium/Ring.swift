//
//  Rings.swift
//  FitnessRingsDemo
//
//  Created by Tarball on 4/27/22.
//

import SwiftUI
import PathText

struct Ring: View {
    @AppStorage("performance") var performance: Bool = false
    public static let lineWidth: CGFloat = 20.0
    public static let tinyLineWidth: CGFloat = 3.0
    @State var color: Color?
    @Binding var progress: Float
    @State var divisor: Float
    @Binding var type: Bool
    @Binding var text: String
    @State var tiny: Bool
    func text(_ text: String) -> NSAttributedString {
        let font = UIFont.boldSystemFont(ofSize: 13)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        let string = NSAttributedString(string: text, attributes: attributes)
        return string
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(lineWidth: tiny ? Ring.tinyLineWidth : Ring.lineWidth)
                    .opacity(0.4)
                    .foregroundColor(color)
                if type {
                    Circle()
                        .trim(from: 0.0, to: CGFloat(progress / divisor))
                        .stroke(style: StrokeStyle(lineWidth: tiny ? Ring.tinyLineWidth : Ring.lineWidth, lineCap: .round))
                        .foregroundColor(color)
                        .rotationEffect(.degrees(270.0 - (Double(progress / divisor) * 180.0)))
                        .shadow(radius: tiny || performance ? 0 : 15)
                } else {
                    Circle()
                        .trim(from: 0.0, to: CGFloat(progress / divisor))
                        .stroke(style: StrokeStyle(lineWidth: tiny ? Ring.tinyLineWidth : Ring.lineWidth, lineCap: .round))
                        .foregroundColor(color)
                        .rotationEffect(.degrees(270.0))
                        .shadow(radius: tiny || performance ? 0 : 15)
                }
                if !tiny {
                    PathText(text: text(text), path: Path() {$0.addArc(center: CGPoint(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY), radius: (geometry.size.width / 2) - 5, startAngle: .degrees(-91), endAngle: .degrees(180), clockwise: false)})
                }
            }
        }
    }
}
