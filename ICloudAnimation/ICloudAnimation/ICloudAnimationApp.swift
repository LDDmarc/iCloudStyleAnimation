//
//  ICloudAnimationApp.swift
//  ICloudAnimation
//
//  Created by Дарья Леонова on 11.05.2025.
//

import SwiftUI

@main
struct ICloudAnimationApp: App {

    @State
    private var viewModel = OrbitingCirclesViewModel(
        persons: [.architect, .advocate, .consul, .adventurer]
    )

    var body: some Scene {
        WindowGroup {
            Text("Hello, World!")
        }
    }
}
