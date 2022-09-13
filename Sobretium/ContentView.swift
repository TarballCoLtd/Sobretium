//
//  ContentView.swift
//  Sobretium
//
//  Created by Alyx Ferrari on 4/27/22.
//
import Time
import SwiftUI

struct ContentView: View {
    @State var date: Date = Date(timeIntervalSince1970: 1641000000)
    @State var date2: Date = Date(timeIntervalSince1970: 1631000000)
    @State var type: Bool = false
    @State var isPresented: Bool = false
    @State var list: SobrietyList = SobrietyList()
    var body: some View {
        NavigationView {
            List {
                // foreach in list
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                NewTimerSheet($list, $isPresented)
            }
        }
    }
    func fart() {
        let clock = Clocks.system
        let time = clock.thisInstant()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
