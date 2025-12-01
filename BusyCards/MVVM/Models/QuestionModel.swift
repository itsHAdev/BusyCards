import Foundation

struct QuestionItem: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String

    init(id: UUID = UUID(), title: String) {
        self.id = id
        self.title = title
    }
}

