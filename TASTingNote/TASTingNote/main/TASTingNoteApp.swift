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
            redWine.self
        ])

        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        return try! ModelContainer(
            for: schema,
            configurations: [configuration]
        )
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
        }
    }
}
