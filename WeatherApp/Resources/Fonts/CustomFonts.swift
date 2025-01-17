//
//  CustomFonts.swift
//  WeatherApp
//
//  Created by Nazar Kozak on 17.01.2025.
//

import SwiftUI

enum Poppins: String {
    case bold = "Poppins-Bold"
    case medium = "Poppins-Medium"
    case regular = "Poppins-Regular"
    case semiBold = "Poppins-SemiBold"
}

extension Font {
    static func custom(_ font: Poppins, size: CGFloat, relativeTo textStyle: Font.TextStyle) -> Font {
        return custom(font.rawValue, size: size, relativeTo: textStyle)
    }
}
