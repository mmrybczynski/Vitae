//
//  TextField.swift
//  Vitae
//
//  Created by Mateusz Rybczyński on 10/11/2025.
//

/*import SwiftUI

struct TextFieldView: View {
    @State var title: LocalizedStringKey
    @State var content: String
    var body: some View {
        if title == "aboutme" {
            TextField(title, text: $content)
                .lineLimit(3, reservesSpace: true)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(Color.secondary.opacity(0.25), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                .padding(.vertical, 8)
                .padding(.horizontal)
                
        } else {
            TextField(title, text: $content)
                .textContentType(.name)
                .submitLabel(.next)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(Color.secondary.opacity(0.25), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                .padding(.vertical, 8)
                .padding(.horizontal)
        }
    }
}*/

import SwiftUI

struct TextFieldView: View {
    enum Kind {
        case name
        case aboutMe
        case surename
    }

    let title: LocalizedStringKey
    @State var content: String
    let kind: Kind

    var body: some View {
        Group {
            switch kind {
            case .aboutMe:
                // Multiline editor
                TextEditor(text: $content)
                    .frame(minHeight: 120)
                    .textInputAutocapitalization(.sentences)
                    .autocorrectionDisabled(false)
                    .accessibilityLabel(title)

            case .name:
                // Single-line name field
                TextField(title, text: $content)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                    .submitLabel(.next)

            case .surename:
                TextField(title, text: $content)
                    .submitLabel(.next)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color.secondary.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}

#Preview {
    TextFieldView(title: "aboutme", content: "", kind: .aboutMe)
}
