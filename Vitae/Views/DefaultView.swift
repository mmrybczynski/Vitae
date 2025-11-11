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
    @State private var countJobs: Int = 1
    @State private var countSchools: Int = 1
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Grid {
                    GridRow {
                        Card(type: .personal)
                        Card(type: .interest)
                    }
                    GridRow {
                        Card(type: .school)
                        Card(type: .job)
                    }
                }
                Button {
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
                } label: {
                    Text(.exportpdf)
                        .foregroundStyle(Color(.black))
                }
            }
            .navigationTitle(.hellolabel)
            .fileMover(isPresented: $showFileMover, file: pdfURL) {result in
                print(result)
            }
        }
    }
}

#Preview {
    DefaultView()
}
