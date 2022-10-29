//
//  AppBanner.swift
//  Sobretium
//
//  Created by Tarball on 10/25/22.
//

import SwiftUI

struct AppBanner: View {
    let hueColors = stride(from: 0.57, to: 0.8, by: 0.001).map {
        Color(hue: $0, saturation: 1, brightness: 1)
    }
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50)
            HStack {
                VStack {
                    Image("SobretiumIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(50)
                        .shadow(color: .black, radius: 20)
                        .padding()
                    Text("Sobretium")
                        .font(.system(size: 70, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(
                            LinearGradient(colors: [.purple, .red, .teal], startPoint: .leading, endPoint: .trailing)
                            //LinearGradient(gradient: Gradient(colors: hueColors), startPoint: .leading, endPoint: .trailing)
                        )
                        .padding()
                }
                Image("iPhone")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(maxWidth: 500)
            }
            Spacer()
        }
    }
}

struct AppBanner_Previews: PreviewProvider {
    static var previews: some View {
        AppBanner()
    }
}
