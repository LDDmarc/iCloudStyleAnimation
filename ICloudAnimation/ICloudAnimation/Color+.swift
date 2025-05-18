//
//  Color+.swift
//  ICloudAnimation
//
//  Created by Дарья Леонова on 14.05.2025.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

/*
 Pastel Purple – #D6B3FF
 Lilac Mist – #E3D0FF
 Pale Pink – #FFCBDD
 Peach Fuzz – #FFD6B5
 Buttercream Yellow – #FFF1A6
 Mint Cream – #D3F9D8
 Powder Blue – #CDE6FF
 Sky Mist – #BFEFFF
 Pastel Teal – #B6E3DD
 Lavender Gray – #D8D4E3
 Soft Coral – #FFB3AB
 Pale Mauve – #EAD6F4
 */
extension Color {
    static let pastelPalette = [
        Color(hex: "#D6B3FF"),
        Color(hex: "#E3D0FF"),
        Color(hex: "#FFCBDD"),
        Color(hex: "#FFD6B5"),
        Color(hex: "#FFF1A6"),
        Color(hex: "#D3F9D8"),
        Color(hex: "#CDE6FF"),
        Color(hex: "#BFEFFF"),
        Color(hex: "#B6E3DD"),
        Color(hex: "#D8D4E3"),
        Color(hex: "#FFB3AB"),
        Color(hex: "#EAD6F4"),
    ]
}
