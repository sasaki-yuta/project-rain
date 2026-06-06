//
//  TASTingNoteApp.swift
//  TASTingNote
//
//  Created by 佐々木 勇太 on 2026/05/09.
//

import SwiftUI
import SwiftData

@main
struct TASTingNoteApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Wine.self,
//            redWine.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError(
                "Could not create ModelContainer: \(error)"
            )
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wine.self)
//                .modelContainer(for: redWine.self)
        }
    }
}
