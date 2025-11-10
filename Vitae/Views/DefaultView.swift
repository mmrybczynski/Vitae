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
        ZStack {
            LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .top, endPoint: .bottom
                        )
                        .ignoresSafeArea() 
            ScrollView {
                // Personal Data
                TextFieldView(title: "personalname", content: defaultData.name)
                
                TextFieldView(title: "surename", content: defaultData.surename)
                
                TextFieldView(title: "aboutme", content: defaultData.description)
                
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
                
                if countSchools < 2 {
                    Button {
                        schoolEntries.append(SchoolEntry())
                        countSchools += 1
                        print(countSchools)
                    } label: {
                        Label(.add, systemImage: "plus.circle.fill")
                    }
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
                
                if countJobs < 2 {
                    Button {
                        entries.append(EmploymentEntry())
                        countJobs += 1
                    } label: {
                        Label(.add, systemImage: "plus.circle.fill")
                    }
                }
                
                
                Button(.exportpdf) {
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
}

#Preview {
    DefaultView()
}
