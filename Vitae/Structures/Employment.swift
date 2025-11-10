//
//  Employment.swift
//  Vitae
//
//  Created by Mateusz Rybczyński on 03/11/2025.
//
import Foundation
import SwiftUI

struct EmploymentEntry: Identifiable, Hashable {
    let id = UUID()
    var name: String = ""
    var surename: String = ""
    var school: String = ""
    var degree: String = ""
    var graduationYear: Date? = nil
    var isCurrentSchool: Bool = false
    var employer: String = ""
    var position: String = ""
    var startDate: Date = Date()
    var endDate: Date? = nil
    var jobDescription: String = ""
    var isCurrent: Bool = false
}
