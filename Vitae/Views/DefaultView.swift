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
    var body: some View {
        NavigationStack {
            List {
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
            .navigationTitle("PDF Test")
            
        }
        .fileMover(isPresented: $showFileMover, file: pdfURL) {result in
            print(result)
        }
    }
}

#Preview {
    DefaultView()
}
