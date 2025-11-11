//
//  PDFMaker.swift
//  Vitae
//
//  Created by Mateusz Rybczyński on 01/11/2025.
//

import SwiftUI
#if os(macOS)
import CoreGraphics
#else
import UIKit
#endif

struct PDFMaker {
    
    enum PDFError: Error {
        case consumerCreationFailed
        case contextCreationFailed
    }
    
    static func create<PageContent: View>(_ pageSize: PageSize = .a4(),
        pageCount: Int,
        //format: UIGraphicsPDFRendererFormat = .default(),
        fileURL: URL = FileManager.default.temporaryDirectory.appending(path: "\(UUID().uuidString).pdf"),
        @ViewBuilder pageContent: (_ pageIndex: Int) -> PageContent
    ) throws -> URL? {
        let size = pageSize.size
        let rect = CGRect(origin: .zero, size: size)
        
#if os(macOS)
        guard let consumer = CGDataConsumer(url: fileURL as CFURL) else {
            throw PDFError.consumerCreationFailed
        }
        var mediaBox = rect
        guard let pdfContext = CGContext(consumer: consumer,
                                         mediaBox: &mediaBox,
                                         nil) else {
            throw PDFError.contextCreationFailed
        }
        for index in 0..<pageCount {
            pdfContext.beginPDFPage(nil)
            let content = pageContent(index).frame(width: size.width, height: size.height)
            let renderer = ImageRenderer(content: content)
            renderer.proposedSize = .init(size)
            pdfContext.translateBy(x: 0, y: size.height)
            pdfContext.scaleBy(x: 1, y: -1)
            renderer.render { _, renderFunc in
                renderFunc(pdfContext)
            }
            pdfContext.endPDFPage()
        }
        pdfContext.closePDF()
#else
        
        let format: UIGraphicsPDFRendererFormat = .default()
        
        
        let renderer = UIGraphicsPDFRenderer(bounds: rect, format: format)
        
        try renderer.writePDF(to: fileURL) {context in
            for index in 0..<pageCount {
                context.beginPage()
                let pageContent = pageContent(index)
                let SwiftUIRenderer = ImageRenderer(content: pageContent.frame(width: size.width, height: size.height))
                SwiftUIRenderer.proposedSize = .init(size)
                
                context.cgContext.translateBy(x: 0, y: size.height)
                context.cgContext.scaleBy(x: 1, y: -1)
                
                SwiftUIRenderer.render {_, swiftUIContext in
                    swiftUIContext(context.cgContext)
                }
            }
        }
#endif
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
