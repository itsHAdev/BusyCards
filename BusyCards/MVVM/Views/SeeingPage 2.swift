




import SwiftUI

struct SeeingPage2: View {
    let videoID: String
    
    @Environment(\.dismiss) private var dismiss
    
    private let primary = Color("DarkBlue")
    
    // رابط يوتيوب الأصلي (لتشغيل الفيديو في التطبيق الخارجي)
    private var youtubeAppURL: URL? {
        // محاولة استخدام مخطط URL الخاص بيوتيوب أولاً
        URL(string: "youtube://watch?v=\(videoID)")
    }
    
    // رابط المتصفح الاحتياطي
    private var youtubeWebURL: URL? {
        URL(string: "https://www.youtube.com/watch?v=\(videoID)")
    }

    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            
            VStack(spacing: 40) {
                
                Image("GG1")
                
                //MARK: - Blue box
                
                VStack(spacing: 15) {
                 
                    Button(action: {
                        // محاولة فتح التطبيق أولاً، وإلا فالمتصفح
                        if let appURL = youtubeAppURL, UIApplication.shared.canOpenURL(appURL) {
                            UIApplication.shared.open(appURL)
                        } else if let webURL = youtubeWebURL {
                            UIApplication.shared.open(webURL)
                        }
                    }) {
                        Text("مشاهدة الفيديو على YouTube")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 25)
                            .background(Capsule().fill(Color.red.opacity(0.8)))
                    }
                }
                .frame(width: 368, height: 214) // الحفاظ على الحجم لضمان التنسيق
                .background(Color.darkBlue) // خلفية المشغل الداكنة
                .cornerRadius(9)
                .padding(.top, 40)
                
                Spacer()
                
                //MARK: - Button انتهيت
                
                NavigationLink{
                    HomePage()
                        .navigationBarBackButtonHidden(true)
                }label: {
                    Text("انتهيت")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .semibold))
                        .frame(maxWidth: 280, minHeight: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(primary)
                                .shadow(color: .black.opacity(0.25), radius: 4, x: 2, y: 3)
                        )
                }

                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
    }
}
#Preview {
    SeeingPage2(videoID: "dQw4w9WgXcQ")
}

