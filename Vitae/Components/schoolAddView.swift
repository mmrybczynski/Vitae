//
//  SchoolAddView.swift
//  Vitae
//
//  Created by Mateusz Rybczyński on 10/11/2025.
//

import SwiftUI

struct schoolAddView: View {
    @Binding var school: SchoolEntry
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("School", text: $school.school)
                .textFieldStyle(.roundedBorder)

            TextField("Degree", text: $school.degree)
                .textFieldStyle(.roundedBorder)

            Toggle("Currently study here", isOn: $school.isCurrentSchool)
                .onChange(of: school.isCurrentSchool) { oldValue, newValue in
                        if newValue { school.graduationYear = nil }
                    }
                
            if !school.isCurrentSchool {
                DatePicker("Graduation year", selection: Binding(
                    get: { school.graduationYear ?? Date() },
                    set: { school.graduationYear = $0 }
                ), displayedComponents: .date)
            }
        }
        .padding()
        .background(.thinMaterial)
        //.background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        //.overlay(
        //    RoundedRectangle(cornerRadius: 12)
        //        .strokeBorder(.quaternary, lineWidth: 1)
        //)
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    schoolAddView(school: .constant(SchoolEntry()))
}
