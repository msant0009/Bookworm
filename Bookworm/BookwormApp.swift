//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Mark Santoro on 12/5/24.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
