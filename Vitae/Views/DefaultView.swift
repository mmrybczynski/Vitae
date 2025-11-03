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
    var body: some View {
        ScrollView {
            
            //Emloyer
            Text("Employment")
                .font(.title)
            
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
