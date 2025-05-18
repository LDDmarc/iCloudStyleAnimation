//
//  PersonInfo.swift
//  ICloudAnimation
//
//  Created by Дарья Леонова on 14.05.2025.
//

import Foundation

struct PersonInfo: Identifiable {
    var id: String { name }
    let name: String
    let icon: String
    let traits: [PersonTrait]
}

extension PersonInfo {
    static let architect = PersonInfo(
        name: "Architect",
        icon: "dog",
        traits: ["♟️", "📐", "🧩", "🗺️", "🤖", "🧠", "🔬"].enumerated().map({ ind, trait in
            PersonTrait(name: trait, weight: .init(rawValue: ind + 1)!)
        })
    )

    static let advocate = PersonInfo(
        name: "Advocate",
        icon: "bird",
        traits: ["🌟", "🤝", "💬", "🎓", "✨", "🕊️", "🗣️"].enumerated().map({ ind, trait in
            PersonTrait(name: trait, weight: .init(rawValue: ind + 1)!)
        })
    )

    static let consul = PersonInfo(
        name: "Consul",
        icon: "elephant",
        traits: ["🤝", "🎁", "🍽️", "🎉", "🌸", "🏡", "🧶"].enumerated().map({ ind, trait in
            PersonTrait(name: trait, weight: .init(rawValue: ind + 1)!)
        })
    )

    static let adventurer = PersonInfo(
        name: "Adventurer",
        icon: "ping",
        traits: ["🎨", "🎵", "🌸", "🌄", "🎻", "💎", "🍃"].enumerated().map({ ind, trait in
            PersonTrait(name: trait, weight: .init(rawValue: ind + 1)!)
        })
    )

}
