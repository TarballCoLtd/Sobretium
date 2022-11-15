//
//  WatchSobrietyRings.swift
//  SobretiumWatch Watch App
//
//  Created by Tarball on 10/6/22.
//

// yes, i know you can share files between targets
// i just didnt want to clutter it up with a bunch of compiler directives
// personal preference i suppose

import SwiftUI

struct SobrietyRings: View {
    @State var seconds: Float = 0
    @State var minutes: Float = 0
    @State var hours: Float = 0
    @State var days: Float = 0
    @State var months: Float = 0
    @ObservedObject var entry: SobrietyEntry
    @State var theme: Theme
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    init(_ entry: SobrietyEntry) {
        self._entry = ObservedObject(initialValue: entry)
        if entry.themeIndex > Theme.themes.count - 1 {
            self._theme = State(initialValue: Theme.prideThemes[Int(entry.themeIndex) - Theme.themes.count])
        } else {
            self._theme = State(initialValue: Theme.themes[Int(entry.themeIndex)])
        }
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Text(String(Int(entry.startDate!.daysAgo)))
                        .font(.system(size: geometry.size.width * 0.19 - 40))
                    Text(entry.startDate!.daysAgo == 1 ? "Day" : "Days")
                }
                .multilineTextAlignment(.center)
                Ring(color: theme.color1, progress: $seconds, divisor: 60)
                    .frame(width: geometry.size.width - ((Ring.lineWidth * 10.0) + 20.0), height: geometry.size.height - ((Ring.lineWidth * 10.0) + 20.0))
                Ring(color: theme.color2, progress: $minutes, divisor: 60)
                    .frame(width: geometry.size.width - ((Ring.lineWidth * 8.0) + 15.0), height: geometry.size.height - ((Ring.lineWidth * 8.0) + 15.0))
                Ring(color: theme.color3, progress: $hours, divisor: 24)
                    .frame(width: geometry.size.width - ((Ring.lineWidth * 6.0) + 10.0), height: geometry.size.height - ((Ring.lineWidth * 6.0) + 10.0))
                Ring(color: theme.color4, progress: $days, divisor: 31)
                    .frame(width: geometry.size.width - ((Ring.lineWidth * 4.0) + 5.0), height: geometry.size.height - ((Ring.lineWidth * 4.0) + 5.0))
                Ring(color: theme.color5, progress: $months, divisor: 12)
                    .frame(width: geometry.size.width - (Ring.lineWidth * 2.0), height: geometry.size.height - (Ring.lineWidth * 2.0))
            }
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
        seconds = self.entry.startDate!.secondsAgoAlt
        minutes = self.entry.startDate!.minutesAgoAlt
        hours = self.entry.startDate!.hoursAgoAlt
        days = self.entry.startDate!.daysAgoAlt
        months = self.entry.startDate!.monthsAgoAlt
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
