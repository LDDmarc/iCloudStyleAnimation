//
//  OrbitingCirclesView.swift
//  ICloudAnimation
//
//  Created by Daria Leonova on 15.05.2025.
//

import SwiftUI

struct OrbitingCirclesView: View {

    var viewModel: OrbitingCirclesViewModel

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                ForEach(viewModel.orbitingCircles) { circle in
                    let angle = circle.startAngle + (viewModel.isSpining ? 360 : 0)
                    let offset = viewModel.isGrouped ? 0 : circle.externalRadius

                    CircleView(viewModel: circle, angle: -angle)
                        .frame(width: circle.radius, height: circle.radius)
                        .offset(x: offset)
                        .rotationEffect(.degrees(angle))
                        .scaleEffect(viewModel.orbitScale)
                }

                CircleView(viewModel: viewModel.center, angle: 0)
                    .frame(
                        width: viewModel.center.radius,
                        height: viewModel.center.radius
                    )
                    .scaleEffect(viewModel.centerScale)
            }
            .scaleEffect(1.1)
            Spacer()
            buttons
        }
    }



    
    @ViewBuilder
    private var buttons: some View {
        Button("Animate") {
            viewModel.startMoving()
        }
        Button("Next") {
            viewModel.next()
        }
    }
}

#Preview {
    OrbitingCirclesView(viewModel: .init(persons: [
        .architect, .adventurer, .advocate, .consul
    ]))
}
