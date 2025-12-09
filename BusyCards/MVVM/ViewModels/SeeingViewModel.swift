//
//  SeeingViewModel.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 09/12/2025.
//

import Foundation
import Combine

class SeeingPageViewModel: ObservableObject {
    // 1. المتغير الذي سيحمل معرّف الفيديو المستخرج
    @Published var videoID: String? = nil
    
    // 2. متغير حالة للتحكم في الانتقال لصفحة عرض الفيديو
    @Published var shouldNavigateToVideo: Bool = false
    
    // دالة استخراج معرّف الفيديو (منطق العمل)
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

    // الدالة العامة التي تستدعيها QuestionView لحفظ الرابط
    func processAndSaveLink(link: String) {
        if let id = extractYouTubeVideoID(from: link) {
            self.videoID = id // تخزين المعرّف
            self.shouldNavigateToVideo = true // تفعيل حالة الانتقال
        } else {
            self.videoID = nil
            self.shouldNavigateToVideo = false
            // يمكن إضافة منطق لعرض رسالة خطأ لليوزر هنا
            print("الرابط المدخل غير صالح لليوتيوب.")
        }
    }
}
