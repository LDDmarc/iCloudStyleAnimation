//
//  OrbitingCirclesViewModel.swift
//  ICloudAnimation
//
//  Created by Дарья Леонова on 15.05.2025.
//

import SwiftUI

@MainActor
@Observable
final class OrbitingCirclesViewModel {

    var orbitingCircles: [CircleViewModel]
    var center: CircleViewModel

    var isSpining = false
    var isGrouped = true


    var orbitScale: CGFloat {
        isOrbitsScaled ? 1.1 : 1
    }
    var centerScale: CGFloat {
        isCenterScaled ? 1.1 : 1
    }

    private let models: [Model]
    private let configuration: OrbitingCirclesViewModelConfiguration

    private var modelIndex = 0
    private var isCenterScaled = false
    private var isOrbitsScaled = false

    convenience init(
        persons: [PersonInfo],
        configuration: OrbitingCirclesViewModelConfiguration = .default
    ) {
        let models = persons.map { monster in
            Model(
                center: .init(content: .image(monster.icon), backgroundColor: .yellow),
                orbitingCircles: monster.traits.map { trait in
                        .init(content: .text(trait.name), backgroundColor: Color.pastelPalette.randomElement()!)
                }
            )
        }
        self.init(models: models, configuration: configuration)
    }

    init(
        models: [Model],
        configuration: OrbitingCirclesViewModelConfiguration
    ) {
        self.models = models
        self.configuration = configuration

        let model = models[0]
        center = CircleViewModel(
            circle: model.center,
            radius: configuration.center.size,
            externalRadius: configuration.center.externalRadius,
            startAngle: configuration.center.startAngle.degrees
        )
        orbitingCircles = zip(model.orbitingCircles, configuration.orbitingCircles).map { model, config in
            CircleViewModel(
                circle: model,
                radius: config.size,
                externalRadius: config.externalRadius,
                startAngle: config.startAngle.degrees
            )
        }
    }

    func startMoving() {
        withAnimation(.bouncy(duration: 0.5, extraBounce: 0.2)) {
            isGrouped.toggle()
        }
        withAnimation(.easeIn(duration: 0.2)) {
            isCenterScaled = true
        } completion: {
            withAnimation(.easeOut(duration: 0.2)) { [unowned self] in
                self.isCenterScaled = false
            }
        }
        withAnimation(.linear(duration: 12).repeatForever(autoreverses: false)) {
            isSpining.toggle()
        }
    }

    func next() {
        modelIndex = (modelIndex + 1) % models.count
        updateWith(model: models[modelIndex])
    }

    private func updateWith(model: Model) {
        withAnimation(.easeIn(duration: 0.2)) {
            isCenterScaled = true
            center = CircleViewModel(circle: model.center, radius: 150)
        } completion: { [unowned self] in
            withAnimation(.easeOut(duration: 0.2)) {
                self.isCenterScaled = false
            }
        }

        withAnimation(.easeIn(duration: 0.2).delay(0.1)) {
            isOrbitsScaled = true
            guard orbitingCircles.count == model.orbitingCircles.count else {
                return
            }
            for index in 0..<orbitingCircles.count {
                orbitingCircles[index].update(with: model.orbitingCircles[index])
            }
        } completion: {
            withAnimation(.easeOut(duration: 0.2)) { [unowned self] in
                self.isOrbitsScaled = false
            }
        }
    }

}

extension OrbitingCirclesViewModel {
    struct Model { // move to protocol?
        let center: Circle
        let orbitingCircles: [Circle]
    }
}

extension OrbitingCirclesViewModel.Model {
    struct Circle {
        let content: Content
        let backgroundColor: Color

        enum Content {
            case text(String)
            case image(String)
        }
    }
}

struct OrbitingCircleConfiguration {
    let size: CGFloat // diameter
    let externalRadius: CGFloat
    let startAngle: Angle
}

struct OrbitingCirclesViewModelConfiguration {
    let center: OrbitingCircleConfiguration
    let orbitingCircles: [OrbitingCircleConfiguration]
}

extension OrbitingCirclesViewModelConfiguration {
    static let `default` = OrbitingCirclesViewModelConfiguration(
        center: .init(size: 150, externalRadius: 0, startAngle: .degrees(0)),
        orbitingCircles: [
            .init(size: 99, externalRadius: 111, startAngle: .degrees(0)),
            .init(size: 98, externalRadius: 100, startAngle: .degrees(190)),
            .init(size: 73, externalRadius: 120, startAngle: .degrees(50)),
            .init(size: 65, externalRadius: 117, startAngle: .degrees(260)),
            .init(size: 55, externalRadius: 121, startAngle: .degrees(330)),
            .init(size: 52, externalRadius: 109, startAngle: .degrees(140)),
            .init(size: 27, externalRadius: 125, startAngle: .degrees(150))
        ]
    )
}

