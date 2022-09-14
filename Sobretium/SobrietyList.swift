//
//  SobrietyList.swift
//  Sobretium
//
//  Created by Alyx Ferrari on 9/13/22.
//

import Foundation

struct SobrietyEntry: Identifiable, Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    var name: String
    var rings: SobrietyRings
    let id = UUID()
}
