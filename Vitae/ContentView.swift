//
//  ContentView.swift
//  Vitae
//
//  Created by Mateusz Rybczyński on 01/11/2025.
//

import SwiftUI
#if os(iOS)
import UIKit
#endif

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var hSizeClass

    private enum Idiom { case phone, pad, mac, other }

    private var idiom: Idiom {
        #if os(macOS)
        return .mac
        #elseif os(iOS)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: return .phone
        case .pad:   return .pad
        default:     return .other
        }
        #else
        return .other
        #endif
    }

    var body: some View {
        switch idiom {
        case .mac:
            MacView() // macOS-specyficzny UI
        case .phone, .pad:
            // iOS/iPadOS: układ sterowany rozmiarem, nie „typem urządzenia”
            Group {
                if hSizeClass == .compact {
                    PhoneView()
                } else {
                    IPadView()
                }
            }
        case .other:
            DefaultView()
        }
    }
}

#Preview("iPhone") {
    ContentView()
}
