// QuestionItem.swift

import Foundation

struct QuestionItem: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    //  خاصية لتخزين رابط الإجابة
    var answerLink: String?

    init(id: UUID = UUID(), title: String, answerLink: String? = nil) {
        self.id = id
        self.title = title
        self.answerLink = answerLink
    }
}
