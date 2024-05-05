//
//  TodoReducer.swift
//  TCA-TODO
//
//  Created by t.nakajima on 2024/05/05.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct TodoReducer {
  @ObservableState
  struct State: Equatable, Identifiable {
    var description = ""
    let id: UUID
    var isComplete = false
  }

  enum Action: BindableAction, Sendable {
    case binding(BindingAction<State>)
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
  }
}

extension IdentifiedArray where ID == TodoReducer.State.ID, Element == TodoReducer.State {
  static let mock: Self = [
    TodoReducer.State(
      description: "テスト１",
      id: UUID(),
      isComplete: false
    ),
    TodoReducer.State(
      description: "テスト２",
      id: UUID(),
      isComplete: false
    ),
    TodoReducer.State(
      description: "テスト３",
      id: UUID(),
      isComplete: true
    ),
  ]
}
