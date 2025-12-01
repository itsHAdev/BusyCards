import Foundation
import Combine
import SwiftUI

@MainActor
final class QuestionsViewModel: ObservableObject {
    @Published private(set) var items: [QuestionItem] = []

    func add(title: String) {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        items.append(QuestionItem(title: title))
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func delete(item: QuestionItem) {
        if let idx = items.firstIndex(of: item) {
            items.remove(at: idx)
        }
    }

    func loadSampleIfNeeded() async {
        guard items.isEmpty else { return }
        // Sample data matching the screenshot
        items = [
            QuestionItem(title: "جدول ضرب أربعة"),
            QuestionItem(title: "جدول ضرب ثلاثة"),
            QuestionItem(title: "جدول ضرب خمسة"),
            QuestionItem(title: "جدول ضرب ستة")
        ]
    }
}

