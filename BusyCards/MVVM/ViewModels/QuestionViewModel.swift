import Foundation
import Combine
import SwiftUI

@MainActor
final class QuestionsViewModel: ObservableObject {

    @Published private(set) var items: [QuestionItem] = []

    private let saveKey = "SavedQuestions"

    // MARK: - Init
    init() {
        load()
    }

    // MARK: - Add
    func add(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        items.append(QuestionItem(title: trimmed))
        save()
    }

    // MARK: - Delete
    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(item: QuestionItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            save()
        }
    }

    // MARK: - Storage
    
    /// احفظ الأسئلة
    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
    
    /// حمّل الأسئلة المحفوظة — بدون أي بيانات أولية
    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let savedItems = try? JSONDecoder().decode([QuestionItem].self, from: data) {
            self.items = savedItems  // عرض الأسئلة اللي حفظها اليوزر سابقًا
        } else {
            self.items = []  // أول تشغيل = فاضية
        }
    }

    // MARK: - Optional explicit loader for .task
    func loadSampleIfNeeded() async {
        // Currently nothing extra to do because init() already calls load().
        // You can add async I/O here later if needed.
    }
    // MARK: - randomQuestion
    func randomQuestion() -> QuestionItem? {
        return items.randomElement()
    }

}
