//
//  FitnessRings.swift
//  FitnessRingsDemo
//
//  Created by Alyx Ferrari on 4/27/22.
//

import SwiftUI

struct SobrietyRings: View {
    @AppStorage("stealth") var stealth: Bool = false
    @AppStorage("performance") var performance: Bool = false
    @State var seconds: Float = 0
    @State var minutes: Float = 0
    @State var hours: Float = 0
    @State var days: Float = 0
    @State var months: Float = 0
    @State var secondsText: String = ""
    @State var minutesText: String = ""
    @State var hoursText: String = ""
    @State var daysText: String = ""
    @State var monthsText: String = ""
    @State var tiny: Bool = false
    @State var date: Date
    @State var type: Bool
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    init(_ tiny: Bool, _ date: Date, _ type: Bool) {
        self._tiny = State(initialValue: tiny)
        self._date = State(initialValue: date)
        self._type = State(initialValue: type)
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if tiny {
                    Ring(color: Color.purple, progress: $hours, divisor: 24, type: $type, text: $hoursText, tiny: tiny)
                        .frame(width: geometry.size.width - ((Ring.tinyLineWidth * 6.0) + 10.0), height: geometry.size.height - ((Ring.tinyLineWidth * 6.0) + 10.0))
                    Ring(color: Color.pink, progress: $days, divisor: 31, type: $type, text: $daysText, tiny: tiny)
                        .frame(width: geometry.size.width - ((Ring.tinyLineWidth * 4.0) + 5.0), height: geometry.size.height - ((Ring.tinyLineWidth * 4.0) + 5.0))
                    Ring(color: Color.orange, progress: $months, divisor: 12, type: $type, text: $monthsText, tiny: tiny)
                        .frame(width: geometry.size.width - (Ring.tinyLineWidth * 2.0), height: geometry.size.height - (Ring.tinyLineWidth * 2.0))
                } else {
                    VStack {
                        Text(String(Int(date.daysAgo)))
                            .font(.system(size: geometry.size.width * 0.19 - 40))
                        if stealth {
                            Text(date.daysAgo == 1 ? "Day" : "Days")
                        } else {
                            Text(date.daysAgo == 1 ? "Day Sober" : "Days Sober")
                        }
                    }
                    .multilineTextAlignment(.center)
                    Ring(color: Color.teal, progress: $seconds, divisor: 60, type: $type, text: $secondsText, tiny: tiny)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 10.0) + 20.0), height: geometry.size.height - ((Ring.lineWidth * 10.0) + 20.0))
                    Ring(color: Color.red, progress: $minutes, divisor: 60, type: $type, text: $minutesText, tiny: tiny)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 8.0) + 15.0), height: geometry.size.height - ((Ring.lineWidth * 8.0) + 15.0))
                    Ring(color: Color.purple, progress: $hours, divisor: 24, type: $type, text: $hoursText, tiny: tiny)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 6.0) + 10.0), height: geometry.size.height - ((Ring.lineWidth * 6.0) + 10.0))
                    Ring(color: Color.pink, progress: $days, divisor: 31, type: $type, text: $daysText, tiny: tiny)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 4.0) + 5.0), height: geometry.size.height - ((Ring.lineWidth * 4.0) + 5.0))
                    Ring(color: Color.orange, progress: $months, divisor: 12, type: $type, text: $monthsText, tiny: tiny)
                        .frame(width: geometry.size.width - (Ring.lineWidth * 2.0), height: geometry.size.height - (Ring.lineWidth * 2.0))
                }
            }
            .shadow(radius: tiny || performance ? 0 : 15)
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            update()
        }
        .onReceive(timer) { _ in
            withAnimation(.easeInOut) {
                update()
            }
        }
    }
    func update() {
        seconds = self.date.secondsAgoAlt
        minutes = self.date.minutesAgoAlt
        hours = self.date.hoursAgoAlt
        days = self.date.daysAgoAlt
        months = self.date.monthsAgoAlt
        secondsText = "\(Int(seconds.rounded(.down))) \(seconds == 1 ? " second" : " seconds")"
        minutesText = "\(Int(minutes.rounded(.down))) \(minutes == 1 ? " minute" : " minutes")"
        hoursText = "\(Int(hours.rounded(.down))) \(hours == 1 ? " hour" : " hours")"
        daysText = "\(Int(days.rounded(.down))) \(days == 1 ? " day" : " days")"
        monthsText = "\(Int(months.rounded(.down))) \(months == 1 ? " month" : " months")"
    }
}

extension Date {
    var secondsAgo: Float {
        return Float(Date().timeIntervalSince(self))
    }
    var minutesAgo: Float {
        let divisor: Float = 60
        return Float(Date().timeIntervalSince(self)) / divisor
    }
    var hoursAgo: Float {
        let divisor: Float = 60 * 60
        return Float(Date().timeIntervalSince(self)) / divisor
    }
    var daysAgo: Float {
        let divisor: Float = 60 * 60 * 24
        return Float(Date().timeIntervalSince(self)) / divisor
    }
    var monthsAgo: Float {
        let divisor: Float = 60 * 60 * 24 * 31
        return Float(Date().timeIntervalSince(self)) / divisor
    }
    var secondsAgoAlt: Float {
        let diff = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: self, to: Date())
        return Float(diff.second ?? 0)
    }
    var minutesAgoAlt: Float {
        let diff = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: self, to: Date())
        return Float(diff.minute ?? 0) + (Float(diff.second ?? 0) / 60)
    }
    var hoursAgoAlt: Float {
        let diff = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: self, to: Date())
        return Float(diff.hour ?? 0)
    }
    var daysAgoAlt: Float {
        let diff = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: self, to: Date())
        return Float(diff.day ?? 0)
    }
    var monthsAgoAlt: Float {
        let diff = Calendar.current.dateComponents([.month, .day, .hour, .minute, .second], from: self, to: Date())
        return Float(diff.month ?? 0)
    }
}
