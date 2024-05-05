//
//  TCA_TODOApp.swift
//  TCA-TODO
//
//  Created by t.nakajima on 2024/05/05.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_TODOApp: App {
    var body: some Scene {
        WindowGroup {
            TopView(
                store: Store(initialState: Todos.State()) {
                    Todos()
                    
                }
            )
        }
    }
}
