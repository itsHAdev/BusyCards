// QuestionItem.swift

import Foundation

struct QuestionItem: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    
    var answerLink: String?
    var link: String?           // Optional video URL
    var mp3FileName: String?    // Optional local MP3 filename

    init(
        id: UUID = UUID(),
        title: String,
        answerLink: String? = nil,
        link: String? = nil,
        mp3FileName: String? = nil
    ) {
        self.id = id
        self.title = title
        self.answerLink = answerLink
        self.link = link
        self.mp3FileName = mp3FileName
    }
}
