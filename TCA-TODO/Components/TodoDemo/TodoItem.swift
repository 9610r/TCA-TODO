//
//  TodoView.swift
//  TCA-TODO
//
//  Created by t.nakajima on 2024/05/05.
//

import ComposableArchitecture
import SwiftUI

struct TodoView: View {
    @Bindable var store: StoreOf<TodoReducer>
    @State var selectedDate = Date()
    var startDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
    var endDate = Calendar.current.date(byAdding: .day, value: 30, to: Date())!

    var body: some View {
        HStack {
            Button {
                store.isComplete.toggle()
            } label: {
                Image(systemName: store.isComplete ? "checkmark.square" : "square")
            }
            .buttonStyle(.plain)
            TextField("Untitled", text: $store.description)
            DatePicker(
                "",
                selection: $selectedDate,
                in: startDate...endDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(.compact)
            .padding()
        }
        .foregroundColor(store.isComplete ? .gray : nil)
    }
}

#Preview {
    TodoView(
        store: Store(initialState: TodoReducer.State(
            description: "テスト１",
            id: UUID(),
            isComplete: false
        )) {
            TodoReducer()
        }
    )
}
