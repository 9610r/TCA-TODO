//
//  TopView.swift
//  TCA-TODO
//
//  Created by t.nakajima on 2024/05/05.
//

import ComposableArchitecture
import SwiftUI

struct TopView: View {
    @Bindable var store: StoreOf<Todos>

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Picker("Filter", selection: $store.filter.animation()) {
                    ForEach(Filter.allCases, id: \.self) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                List {
                    ForEach(store.scope(state: \.filteredTodos, action: \.todos)) { store in
                        TodoView(store: store)
                    }
                    .onDelete { store.send(.delete($0)) }
                    .onMove { store.send(.move($0, $1)) }
                }
            }
            .navigationTitle("Todos")
            .navigationBarItems(
                trailing: HStack(spacing: 20) {
                    EditButton()
                    Button {
                        store.send(.clearCompletedButtonTapped, animation: .default)
                    } label: {
//                        Image(.trash)
                        Text("Clear")
                    }
                    .disabled(!store.todos.contains(where: \.isComplete))
                    Button("Add Todo") {
                        store.send(.addTodoButtonTapped, animation: .default)
                    }
                }
            )
            .environment(\.editMode, $store.editMode)
        }
    }
}

#Preview {
    TopView(
        store: Store(initialState: Todos.State(todos: .mock)) {
            Todos()
        }
    )
}
