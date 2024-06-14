//
//  SwiftDataTestApp.swift
//  SwiftDataTest
//
//  Created by Kaique Diniz on 11/06/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [AssignmentModel.self])
    }
}
