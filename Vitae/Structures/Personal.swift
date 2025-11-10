//
//  Personal.swift
//  Vitae
//
//  Created by Mateusz Rybczyński on 10/11/2025.
//

import Foundation
import SwiftUI

struct PersonalEntry: Identifiable, Hashable {
    let id = UUID()
    var name: String = ""
    var surename: String = ""
    var description: String = ""
}
