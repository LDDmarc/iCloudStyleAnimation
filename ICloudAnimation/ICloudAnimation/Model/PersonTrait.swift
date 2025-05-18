//
//  PersonTrait.swift
//  ICloudAnimation
//
//  Created by Дарья Леонова on 14.05.2025.
//

import Foundation

struct PersonTrait: Identifiable {
    let id = UUID()
    let name: String
    let weight: Weight
}

extension PersonTrait {
    enum Weight: Int {
        case one = 1, two, three, four, five, six, seven
    }
}
