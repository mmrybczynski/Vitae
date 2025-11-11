//
//  School.swift
//  Vitae
//
//  Created by Mateusz Rybczyński on 10/11/2025.
//

import Foundation
import SwiftUI

struct SchoolEntry: Identifiable, Hashable {
    let id = UUID()
    var school: String = ""
    var degree: String = ""
    var graduationYear: Date? = nil
    var isCurrentSchool: Bool = false
}
