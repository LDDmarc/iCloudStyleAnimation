//
//  CircleViewModel.swift
//  ICloudAnimation
//
//  Created by Дарья Леонова on 15.05.2025.
//

import SwiftUI

@MainActor
@Observable
final class CircleViewModel: Identifiable, CircleViewModelInterface {
    typealias CircleModel = OrbitingCirclesViewModel.Model.Circle

    let id = UUID()
    let radius: CGFloat
    let externalRadius: CGFloat
    let startAngle: Double
    var color: Color {
        circle.backgroundColor
    }
    var content: CircleModel.Content {
        circle.content
    }
    
    private var circle: CircleModel

    init(
        circle: CircleModel,
        radius: CGFloat,
        externalRadius: CGFloat = 0,
        startAngle: Double = 0
    ) {
        self.circle = circle
        self.radius = radius
        self.externalRadius = externalRadius
        self.startAngle = startAngle
    }

    func update(with circle: CircleModel) {
        self.circle = circle
    }
}
