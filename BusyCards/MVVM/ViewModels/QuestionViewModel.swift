// QuestionsViewModel.swift
// QuestionsViewModel.swift

import Foundation
import SwiftUI
import Combine

@MainActor
final class QuestionsViewModel: ObservableObject {

    // MARK: - Published properties
    @Published private(set) var items: [QuestionItem] = []

    // Video handling
    @Published var extractedVideoID: String? = nil
    @Published var shouldShowVideoPlayer: Bool = false

    private let saveKey = "SavedQuestions"

    // MARK: - Init
    init() { load() }

    // MARK: - Add / Process

    /// Adds a question with optional link and mp3 file
    func add(title: String, link: String? = nil, mp3FileName: String? = nil) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        // If a link exists, try to extract YouTube ID
        var videoID: String? = nil
        if let link = link, !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            videoID = extractYouTubeVideoID(from: link)
        }

        // Save question
        items.append(QuestionItem(title: trimmed, link: link, mp3FileName: mp3FileName))

        // Reset video transition flags
        self.extractedVideoID = nil
        self.shouldShowVideoPlayer = false

        save()
    }

    /// Processes title and link (friend’s logic for YouTube detection)
    func processAndSave(title: String, link: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }

        let videoID = extractYouTubeVideoID(from: link)
        let linkToSave = (videoID != nil && !link.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) ? link : nil

        items.append(QuestionItem(title: trimmedTitle, link: linkToSave))

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
    private func save() {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let savedItems = try? JSONDecoder().decode([QuestionItem].self, from: data) {
            self.items = savedItems
        } else {
            self.items = []
        }
    }

    // MARK: - Random Question
    func randomQuestion() -> QuestionItem? {
        items.randomElement()
    }

    // MARK: - YouTube ID Extraction
    private func extractYouTubeVideoID(from urlString: String) -> String? {
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
}
