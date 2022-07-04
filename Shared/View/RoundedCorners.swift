//
//  RoundedCorners.swift
//  Coppel (iOS)
//
//  Created by Jesús Francisco Leyva Juárez on 03/07/22.
//

import SwiftUI

struct RoundedCorners: Shape {
    var corners: UIRectCorner = .allCorners
    var radius: CGFloat = .infinity
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

