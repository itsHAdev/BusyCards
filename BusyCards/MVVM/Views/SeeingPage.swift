import SwiftUI

struct SeeingPage: View {
    @Environment(\.dismiss) private var dismiss
    
    // Asset-backed colors used elsewhere in the project
    private let bg = Color("Background")
    private let primary = Color("DarkBlue")
    
    @StateObject private var viewModel = QuestionsViewModel()
    @State private var question: QuestionItem?
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                bg.ignoresSafeArea()
                
                VStack(spacing: 152) {
                    
                    // Illustration
                    Image("GG1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280, height: 280)
                    
                    // Question text
                    Text(question?.title ?? "لا يوجد سؤال")
                        .font(.system(size: 34))
                        .multilineTextAlignment(.center)
                    
                    NavigationLink {
                        SeeingPage2(videoID: "dQw4w9WgXcQ")
                            .navigationBarBackButtonHidden(false)
                    } label: {
                        Text("انظر للإجابة")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .semibold))
                            .frame(maxWidth: 280, minHeight: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(primary)
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 2, y: 3)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .onAppear {
            // اختار سؤال عشوائي لو فيه أسئلة، وإلا يظل nil
            question = viewModel.randomQuestion()
        }
 .environment(\.layoutDirection, .rightToLeft)
 .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    SeeingPage()
}

// A lightweight glassy circular button, visually matching your existing style
private struct GlassCircle: View {
    let systemName: String
    var diameter: CGFloat = 46
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black.opacity(0.85))
                .frame(width: diameter, height: diameter)
                .background(
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.35))
                        Circle()
                            .stroke(Color.black.opacity(0.08), lineWidth: 1)
                            .blur(radius: 1.2)
                            .offset(y: 1)
                            .mask(
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.black, .clear],
                                            startPoint: .bottom,
                                            endPoint: .top
                                        )
                                    )
                            )
                        Circle()
                            .stroke(Color.white.opacity(0.85), lineWidth: 1.1)
                            .blendMode(.plusLighter)
                    }
                )
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.45))
                        .blur(radius: 8)
                        .opacity(0.7)
                )
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
        .contentShape(Circle())
    }
}
