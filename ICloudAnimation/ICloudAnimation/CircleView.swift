//
//  CircleView.swift
//  ICloudAnimation
//
//  Created by Дарья Леонова on 15.05.2025.
//

import SwiftUI

@MainActor
protocol CircleViewModelInterface {
    var color: Color { get }
    var content: OrbitingCirclesViewModel.Model.Circle.Content { get }
}

struct CircleView<ViewModel: CircleViewModelInterface>: View {
    var viewModel: ViewModel
    let angle: Double

    init(viewModel: ViewModel, angle: Double) {
        self.viewModel = viewModel
        self.angle = angle
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Group {
                    background(size: proxy.size)
                    content(size: proxy.size)
                }
                .rotationEffect(.degrees(angle))
            }
        }
    }

    @ViewBuilder
    private func background(size: CGSize) -> some View {
        let shadowValue = size.width / 60
        Circle()
            .fill(viewModel.color)
            .frame(width: size.width, height: size.height)
            .shadow(
                radius: shadowValue,
                x: shadowValue,
                y: shadowValue
            )
    }

    @ViewBuilder
    private func content(size: CGSize) -> some View {
        switch viewModel.content {
        case .text(let text):
            Text(text)
                .font(.system(size: 0.6 * size.width))
        case .image(let image):
            Image(image)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
        }
    }
}

#Preview {
    CircleView(viewModel: CircleViewModelMock(color: .yellow, content: .text("♟️")), angle: 0)
        .padding()

    CircleView(viewModel: CircleViewModelMock(color: .yellow, content: .image("ping")), angle: 0)
        .padding()
}

final class CircleViewModelMock: CircleViewModelInterface {
    var color: Color
    var content: OrbitingCirclesViewModel.Model.Circle.Content

    init(color: Color, content: OrbitingCirclesViewModel.Model.Circle.Content) {
        self.color = color
        self.content = content
    }
}
