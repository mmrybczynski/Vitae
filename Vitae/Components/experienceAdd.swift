//
//  experienceAdd.swift
//  Vitae
//
//  Created by Mateusz Rybczyński on 11/11/2025.
//

import SwiftUI

struct experienceAdd: View {
    @Binding var entry: EmploymentEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField(.employer, text: $entry.employer)
                .textFieldStyle(.roundedBorder)

            TextField(.position, text: $entry.position)
                .textFieldStyle(.roundedBorder)

            DatePicker(.jobStartDatee, selection: $entry.startDate, displayedComponents: .date)

            Toggle(.currentlyjob, isOn: $entry.isCurrent)
                .onChange(of: entry.isCurrent) { oldValue, newValue in
                        if newValue { entry.endDate = nil }
                    }
                
            if !entry.isCurrent {
                DatePicker(.jobEndDate, selection: Binding(
                    get: { entry.endDate ?? Date() },
                    set: { entry.endDate = $0 }
                ), displayedComponents: .date)
            }

            TextField(.jobDescription, text: $entry.jobDescription, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(3, reservesSpace: true)
        }
        .padding()
        //.background(.ultraThinMaterial)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(.quaternary, lineWidth: 1)
        )
        .accessibilityElement(children: .contain)
        .padding()
    }
}

#Preview {
    experienceAdd(entry: .constant(EmploymentEntry()))
}
