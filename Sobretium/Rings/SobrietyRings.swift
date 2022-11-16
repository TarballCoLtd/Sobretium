//
//  FitnessRings.swift
//  FitnessRingsDemo
//
//  Created by Tarball on 4/27/22.
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
    @State var years: Float = 0
    @State var secondsText: String = ""
    @State var minutesText: String = ""
    @State var hoursText: String = ""
    @State var daysText: String = ""
    @State var monthsText: String = ""
    @State var yearsText: String = ""
    //@State var tiny: Bool = false
    @ObservedObject var entry: SobrietyEntry
    @State var type: Bool
    @State var theme: Theme
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    init(_ entry: SobrietyEntry, _ type: Bool) {
        //self._tiny = State(initialValue: tiny)
        self._entry = ObservedObject(initialValue: entry)
        self._type = State(initialValue: type)
        if entry.themeIndex > Theme.themes.count - 1 {
            self._theme = State(initialValue: Theme.prideThemes[Int(entry.themeIndex) - Theme.themes.count])
        } else {
            self._theme = State(initialValue: Theme.themes[Int(entry.themeIndex)])
        }
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                /*
                if tiny {
                    Ring(color: theme.color3, textColor: theme.textColor3, progress: $hours, divisor: 24, type: $type, text: $hoursText, tiny: tiny)
                        .frame(width: geometry.size.width - ((Ring.tinyLineWidth * 6.0) + 10.0), height: geometry.size.height - ((Ring.tinyLineWidth * 6.0) + 10.0))
                    Ring(color: theme.color4, textColor: theme.textColor4, progress: $days, divisor: 31, type: $type, text: $daysText, tiny: tiny)
                        .frame(width: geometry.size.width - ((Ring.tinyLineWidth * 4.0) + 5.0), height: geometry.size.height - ((Ring.tinyLineWidth * 4.0) + 5.0))
                    Ring(color: theme.color5, textColor: theme.textColor5, progress: $months, divisor: 12, type: $type, text: $monthsText, tiny: tiny)
                        .frame(width: geometry.size.width - (Ring.tinyLineWidth * 2.0), height: geometry.size.height - (Ring.tinyLineWidth * 2.0))
                }
                */
                VStack {
                    Text(entry.startDate!.daysAgoStringTruncated)
                        .font(.system(size: geometry.size.width * 0.19 - 40))
                    Text(entry.startDate!.daysAgo == 1 ? "Day" : "Days")
                }
                .multilineTextAlignment(.center)
                if years < 1 {
                    Ring(color: theme.color1, textColor: theme.textColor1, progress: $seconds, divisor: 60, type: $type, text: $secondsText, tiny: false)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 10.0) + 20.0), height: geometry.size.height - ((Ring.lineWidth * 10.0) + 20.0))
                    Ring(color: theme.color2, textColor: theme.textColor2, progress: $minutes, divisor: 60, type: $type, text: $minutesText, tiny: false)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 8.0) + 15.0), height: geometry.size.height - ((Ring.lineWidth * 8.0) + 15.0))
                    Ring(color: theme.color3, textColor: theme.textColor3, progress: $hours, divisor: 24, type: $type, text: $hoursText, tiny: false)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 6.0) + 10.0), height: geometry.size.height - ((Ring.lineWidth * 6.0) + 10.0))
                    Ring(color: theme.color4, textColor: theme.textColor4, progress: $days, divisor: 31, type: $type, text: $daysText, tiny: false)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 4.0) + 5.0), height: geometry.size.height - ((Ring.lineWidth * 4.0) + 5.0))
                    Ring(color: theme.color5, textColor: theme.textColor5, progress: $months, divisor: 12, type: $type, text: $monthsText, tiny: false)
                        .frame(width: geometry.size.width - (Ring.lineWidth * 2.0), height: geometry.size.height - (Ring.lineWidth * 2.0))
                } else {
                    Ring(color: theme.color1, textColor: theme.textColor1, progress: $minutes, divisor: 60, type: $type, text: $minutesText, tiny: false)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 10.0) + 20.0), height: geometry.size.height - ((Ring.lineWidth * 10.0) + 20.0))
                    Ring(color: theme.color2, textColor: theme.textColor2, progress: $hours, divisor: 24, type: $type, text: $hoursText, tiny: false)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 8.0) + 15.0), height: geometry.size.height - ((Ring.lineWidth * 8.0) + 15.0))
                    Ring(color: theme.color3, textColor: theme.textColor3, progress: $days, divisor: 31, type: $type, text: $daysText, tiny: false)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 6.0) + 10.0), height: geometry.size.height - ((Ring.lineWidth * 6.0) + 10.0))
                    Ring(color: theme.color4, textColor: theme.textColor4, progress: $months, divisor: 12, type: $type, text: $monthsText, tiny: false)
                        .frame(width: geometry.size.width - ((Ring.lineWidth * 4.0) + 5.0), height: geometry.size.height - ((Ring.lineWidth * 4.0) + 5.0))
                    Ring(color: theme.color5, textColor: theme.textColor5, progress: $years, divisor: 10, type: $type, text: $yearsText, tiny: false)
                        .frame(width: geometry.size.width - (Ring.lineWidth * 2.0), height: geometry.size.height - (Ring.lineWidth * 2.0))
                }
            }
            .shadow(radius: performance ? 0 : 15)
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
        guard let date = entry.startDate else { return }
        seconds = date.secondsAgoAlt
        minutes = date.minutesAgoAlt
        hours = date.hoursAgoAlt
        days = date.daysAgoAlt
        months = date.monthsAgoAlt
        years = date.yearsAgoAlt
        secondsText = "\(Int(seconds.rounded(.down))) \(Int(seconds.rounded(.down)) == 1 ? " second" : " seconds")"
        minutesText = "\(Int(minutes.rounded(.down))) \(Int(minutes.rounded(.down)) == 1 ? " minute" : " minutes")"
        hoursText = "\(Int(hours.rounded(.down))) \(Int(hours.rounded(.down)) == 1 ? " hour" : " hours")"
        daysText = "\(Int(days.rounded(.down))) \(Int(days.rounded(.down)) == 1 ? " day" : " days")"
        monthsText = "\(Int(months.rounded(.down))) \(Int(months.rounded(.down)) == 1 ? " month" : " months")"
        yearsText = "\(Int(years.rounded(.down))) \(Int(years.rounded(.down)) == 1 ? " year" : " years")"
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
    var daysAgoAbs: Float {
        return self.daysAgo < 0 ? 0 : self.daysAgo
    }
    var daysAgoStringTruncated: String {
        return String(Int(self.daysAgoAbs))
    }
    var monthsAgo: Float {
        let divisor: Float = 60 * 60 * 24 * 31
        return Float(Date().timeIntervalSince(self)) / divisor
    }
    var yearsAgo: Float {
        let divisor: Float = 60 * 60 * 24 * 365
        return Float(Date().timeIntervalSince(self)) / divisor
    }
    var secondsAgoAlt: Float {
        let diff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        return Float(diff.second ?? 0)
    }
    var minutesAgoAlt: Float {
        let diff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        return Float(diff.minute ?? 0) + (self.secondsAgoAlt / 60)
    }
    var hoursAgoAlt: Float {
        let diff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        return Float(diff.hour ?? 0) + (self.minutesAgoAlt / 60)
    }
    var daysAgoAlt: Float {
        let diff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        return Float(diff.day ?? 0) + (self.hoursAgoAlt / 24)
    }
    var monthsAgoAlt: Float {
        let diff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        return Float(diff.month ?? 0) + (self.daysAgoAlt / 31)
    }
    var yearsAgoAlt: Float {
        let diff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        return (Float(diff.year ?? 0) + (self.monthsAgoAlt / 12))
    }
}
