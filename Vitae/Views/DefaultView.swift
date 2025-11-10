//
//  DefaultView.swift
//  Vitae
//
//  Created by Mateusz Rybczyński on 01/11/2025.
//

import SwiftUI

struct DefaultView: View {
    @State private var pdfURL: URL?
    @State private var showFileMover: Bool = false
    @State private var entries: [EmploymentEntry] = [EmploymentEntry()]
    @State private var schoolEntries: [SchoolEntry] = [SchoolEntry()]
    @State private var defaultData = PersonalEntry()
    var body: some View {
        ScrollView {
            // Personal Data
            TextField("Name", text: $defaultData.name)
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
                .padding(.vertical, 4)
            TextField("Surename", text: $defaultData.surename)
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
                .padding(.vertical, 4)
            TextField("About me", text: $defaultData.description)
                .textContentType(.none)
                .submitLabel(.done)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(Color.secondary.opacity(0.25), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                .padding(.vertical, 4)
            
            
            // School
            ForEach($schoolEntries) { $entry in
                schoolAddView(school: $entry)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
            .onDelete { indexSet in
                schoolEntries.remove(atOffsets: indexSet)
            }
            .onMove { from, to in
                schoolEntries.move(fromOffsets: from, toOffset: to)
            }
            
            Button {
                schoolEntries.append(SchoolEntry())
            } label: {
                Label("Add", systemImage: "plus.circle.fill")
            }
            
            //Emloyer
            ForEach($entries) { $entry in
                experienceAddView(entry: $entry)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
            .onDelete { indexSet in
                entries.remove(atOffsets: indexSet)
            }
            .onMove { from, to in
                entries.move(fromOffsets: from, toOffset: to)
            }
            
            Button {
                entries.append(EmploymentEntry())
            } label: {
                Label("Add", systemImage: "plus.circle.fill")
            }
            
            Button("Export PDF") {
                if let pdfURL = try? PDFMaker.create(pageCount: 1, pageContent: { pageIndex in
                    VStack {
                        HStack {
                            Text("Mateusz Rybczyński")
                        }
                        Spacer()
                    }
                }) {
                    self.pdfURL = pdfURL
                    showFileMover.toggle()
                }
            }
            
        }
        .fileMover(isPresented: $showFileMover, file: pdfURL) {result in
            print(result)
        }
    }
}

#Preview {
    DefaultView()
}
