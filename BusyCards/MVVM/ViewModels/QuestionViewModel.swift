// QuestionsViewModel.swift

import Foundation
import Combine
import SwiftUI

@MainActor
final class QuestionsViewModel: ObservableObject {

    @Published private(set) var items: [QuestionItem] = []
    
    // متغيرات حالة خاصة بمعالجة الفيديو والانتقال
    @Published var extractedVideoID: String? = nil
    // ✅ القيمة يجب أن تكون FALSE لضمان عدم الانتقال
    @Published var shouldShowVideoPlayer: Bool = false

    private let saveKey = "SavedQuestions"

    // MARK: - Init
    init() {
        load()
    }

    // MARK: - YouTube Link Processing Logic
    
    private func extractYouTubeVideoID(from urlString: String) -> String? {
        // Regular expression for common YouTube URLs
        let pattern = "(?<=v(=|/))([a-zA-Z0-9_-]+)|(?<=youtu\\.be/)([a-zA-Z0-9_-]+)"
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            let nsString = urlString as NSString
            let results = regex.matches(in: urlString, options: [], range: NSRange(location: 0, length: nsString.length))
            
            for result in results {
                for i in 1..<result.numberOfRanges {
                    let range = result.range(at: i)
                    if range.location != NSNotFound {
                        return nsString.substring(with: range)
                    }
                }
            }
        }
        return nil
    }
    
    // MARK: - Add / Process
    
    /// دالة مُعدّلة لمعالجة الرابط وحفظ السؤال
    func processAndSave(title: String, link: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }

        // محاولة استخراج ID لتخزينه (إذا كان صالحاً)
        let videoID = extractYouTubeVideoID(from: link)
        let linkToSave = (videoID != nil && !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) ? link : nil
        
        // حفظ السؤال (مع الرابط أو بدونه)
        items.append(QuestionItem(title: trimmedTitle, answerLink: linkToSave))
        
        // ✅ التعديل الحاسم: نضمن أن حالة الانتقال معطلة دائمًا بعد الحفظ
        self.extractedVideoID = nil
        self.shouldShowVideoPlayer = false
        
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
    
    /// حمّل الأسئلة المحفوظة
    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let savedItems = try? JSONDecoder().decode([QuestionItem].self, from: data) {
            self.items = savedItems
        } else {
            self.items = []
        }
    }

    // MARK: - randomQuestion
    func randomQuestion() -> QuestionItem? {
        return items.randomElement()
    }
}
