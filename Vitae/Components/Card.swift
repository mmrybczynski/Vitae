//
//  Card.swift
//  Vitae
//
//  Created by Mateusz Rybczyński on 11/11/2025.
//

import SwiftUI
import Foundation

enum TypeOfButton: String, CaseIterable, Identifiable {
    case personal
    case school
    case job
    case interest

    var id: String { self.rawValue }

    var displayText: LocalizedStringKey {
        switch self {
        case .personal:
            return "personalname"
        case .school:
            return "school"
        case .job:
            return "joblabel"
        case .interest:
            return "interest"
        }
    }

    var imageName: String {
        switch self {
        case .personal:
            return "👤"
        case .school:
            return "🏫"
        case .job:
            return "💼"
        case .interest:
            return "🎨"
        }
    }
    
    @ViewBuilder
        var destinationView: some View {
            switch self {
            case .personal, .school, .job, .interest:
                EmploymentFormView()
            }
        }
}

struct Card: View {
    @State private var selection: TypeOfButton
    
    init(type: TypeOfButton) {
        self._selection = State(initialValue: type)
    }
    
    var body: some View {
        NavigationLink(destination: AnyView(selection.destinationView), label: {
            VStack {
                Text(selection.imageName)
                Text(selection.displayText)
                    .foregroundStyle(Color(.black))
            }
            .frame(width: 110, height: 80)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
        })
        
    }
}

#Preview {
    Card(type: .personal)
}
