//
//  PDFMaker.swift
//  Vitae
//
//  Created by Mateusz Rybczyński on 01/11/2025.
//

import SwiftUI
import PDFKit

struct PDFMaker {
    
    static func create<PageContent: View>(_ pageSize: PageSize = .a4(),
        pageCount: Int,
        format: UIGraphicsPDFRendererFormat = .default(),
        fileURL: URL = FileManager.default.temporaryDirectory.appending(path: "\(UUID().uuidString).pdf"),
        @ViewBuilder pageContent: (_ pageIndex: Int) -> PageContent
    ) throws -> URL? {
        let size = pageSize.size
        let rect = CGRect(origin: .zero, size: size)
        
        let renderer = UIGraphicsPDFRenderer(bounds: rect, format: format)
        
        try renderer.writePDF(to: fileURL) {context in
            for index in 0..<pageCount {
                context.beginPage()
                let pageContent = pageContent(index)
                let SwiftUIRenderer = ImageRenderer(content: pageContent.frame(width: size.width, height: size.height))
                SwiftUIRenderer.proposedSize = .init(size)
                SwiftUIRenderer.render {_, swiftUIContext in
                    swiftUIContext(context.cgContext)
                }
            }
        }
        return fileURL
    }
    
    struct PageSize {
        let size: CGSize
        init(width: CGFloat, height: CGFloat) {
            self.size = .init(width: width, height: height)
        }
        
        static func a4() -> Self {
            .init(width: 595.2, height: 841.8)
        }
    }
}
