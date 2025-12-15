
import SwiftUI
import UniformTypeIdentifiers

struct QuestionView: View {
    @StateObject private var viewModel = QuestionsViewModel()
    @State private var showingAddCard = false
    @State private var newTitle: String = ""
    @State private var newLink: String = ""
    @State private var mp3FileName: String? = nil
    @State private var videoFileName: String? = nil
    @State private var showingFileImporter = false

    @FocusState private var isFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss

    private let baseBg = Color(red: 0.96, green: 0.90, blue: 0.90)
    
    enum FilePickerType {
        case video
        case audio
    }

    @State private var pickerType: FilePickerType? = nil


    var body: some View {
        NavigationStack{
            ZStack {
                baseBg
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    //                header
                    //                    .padding(.horizontal, 16)
                    //                    .padding(.top, 16)
                    //                    .padding(.bottom, 12)
                    
                    List {
                        ForEach(viewModel.items) { item in
                            Text(item.title)
                                .font(.custom("SF Arabic Rounded", size: 22))
                                .lineLimit(nil)
                                .lineSpacing(4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 14)
                                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                                .listRowBackground(Color.clear)
                                .swipeActions(edge: .leading) {
                                    Button(role: .destructive) {
                                        deleteItem(item)
                                    } label: {
                                        Text("حذف")
                                    }
                                }
                        }
                    }
                    .environment(\.layoutDirection, .rightToLeft)
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    .listRowSeparator(.hidden)
                    .safeAreaPadding(.top, 4)
                }//v
                
                //MARK: - Toolbar
                
                .toolbar {
                    
                    // العنوان بالنص
                    ToolbarItem(placement: .principal) {
                        Text("أسئلة اليوم")
                            .font(.custom("SF Arabic Rounded", size: 25))
                    }
                    
                    // زر الإضافة (يمين)
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAddCard.toggle()
                            if showingAddCard {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                    isFieldFocused = true
                                }
                            } else {
                                cancelAdd()
                            }
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 20))
                                .foregroundColor(.black) 
                        }
                    }
                }//tool
                
                if showingAddCard {
                    ZStack {
                        Color.black.opacity(0.15)
                            .ignoresSafeArea()
                            .onTapGesture { cancelAdd() }
                        
                        addCard
                            .padding(.horizontal, 24)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.95).combined(with: .opacity),
                        removal: .opacity
                    ))
                    .zIndex(1)
                }
            }//z
            .animation(.spring(response: 0.35, dampingFraction: 0.9), value: showingAddCard)
            .environment(\.layoutDirection, .rightToLeft)
//            
//             Video full screen cover (friend's logic)
//            .fullScreenCover(isPresented: $viewModel.shouldShowVideoPlayer) {
//                if let videoID = viewModel.extractedVideoID {
//                    SeeingPage2()
//                } else {
//                    Text("خطأ في تحميل الفيديو")
//                }
//            }
        }//nav
    }

//    // MARK: - Header
//    private var header: some View {
//        ZStack {
//            Text("أسئلة اليوم")
//                .font(.custom("SF Arabic Rounded", size: 25))
//                .foregroundStyle(.primary)
//                .multilineTextAlignment(.center)
//
//            HStack {
//                GlassCircleButton(systemName: "plus", diameter: 48, baseBackground: baseBg) {
//                    showingAddCard.toggle()
//                    if showingAddCard {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//                            isFieldFocused = true
//                        }
//                    } else {
//                        cancelAdd()
//                    }
//                }
//                Spacer()
//            }//h
//        }
//        .frame(maxWidth: .infinity, minHeight: 64, alignment: .center)
//        .padding(.horizontal, 4)
//    }

    // MARK: - Add Card
    private var addCard: some View {
        VStack(alignment: .trailing, spacing: 20) {
            
            //MARK: add Q
            Text("أضف سؤال")
                .font(.custom("SF Arabic Rounded", size: 26).weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField("سؤال", text: $newTitle)
                .focused($isFieldFocused)
                .textInputAutocapitalization(.sentences)
                .submitLabel(.done)
                .padding(.horizontal, 20)
                .padding(.vertical, 18)
                .background(Capsule().fill(Color(.systemGray6)))
                .font(.custom("SF Arabic Rounded", size: 22))
                .foregroundStyle(.primary)
            
            //MARK: - addVideo

            Text("أضف ملف يوتيوب للإجابة")
                .font(.custom("SF Arabic Rounded", size: 26).weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 4)

            Button(action: {
                pickerType = .video
                showingFileImporter = true
            })
                {
                HStack {
                    Text(videoFileName ?? "اختر ملف فيديو")
                        .font(.custom("SF Arabic Rounded", size: 22))
                    Spacer()
                    Image(systemName: "doc.fill")
                        .background(Capsule().fill(Color(.systemGray6)))
                }
                .padding()
                .background(Capsule().fill(Color(.systemGray6)))
            }

            //MARK: - addAudio
            
            Text("اختر ملف صوت للإجابة")
                .font(.custom("SF Arabic Rounded", size: 26).weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 4)

            Button(action: {
                pickerType = .audio
                showingFileImporter = true
            }) {
                HStack {
                    Text(mp3FileName ?? "اختر ملف صوت")
                        .font(.custom("SF Arabic Rounded", size: 22))
                    Spacer()
                    Image(systemName: "doc.fill")
                        .background(Capsule().fill(Color(.systemGray6)))
                }
                .padding()
                .background(Capsule().fill(Color(.systemGray6)))
            }

            HStack(spacing: 16) {
                Button(action: cancelAdd) {
                    Text("إلغاء")
                        .font(.custom("SF Arabic Rounded", size: 22).weight(.semibold))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Capsule().fill(Color(.systemGray6)))
                }

                Button(action: saveAdd) {
                    Text("حفظ")
                        .font(.custom("SF Arabic Rounded", size: 22).weight(.semibold))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Capsule().fill(Color(.systemGray6)))
                }
                .disabled(newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1)
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 8)
        )
        //MARK: - fileImprter
        
        .fileImporter(
            isPresented: $showingFileImporter,
            allowedContentTypes: pickerType == .video
                ? [.movie]
                : [.audio]
        ) { result in
            switch result {
            case .success(let url):
                let filename = url.lastPathComponent
                let destURL = FileManager.default
                    .urls(for: .documentDirectory, in: .userDomainMask)[0]
                    .appendingPathComponent(filename)

                try? FileManager.default.copyItem(at: url, to: destURL)

                if pickerType == .video {
                    videoFileName = filename
                } else {
                    mp3FileName = filename
                }

                pickerType = nil

            case .failure(let error):
                print("Error picking file: \(error.localizedDescription)")
                pickerType = nil
            }
        }

    }//body

    // MARK: - Actions
    private func saveAdd() {
        let trimmedTitle = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }

        viewModel.add(title: trimmedTitle,
                      link: newLink.trimmingCharacters(in: .whitespacesAndNewlines),
                      mp3FileName: mp3FileName)

        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        newTitle = ""
        newLink = ""
        mp3FileName = nil
        isFieldFocused = false
        showingAddCard = false
    }

    private func cancelAdd() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        newTitle = ""
        newLink = ""
        mp3FileName = nil
        isFieldFocused = false
        showingAddCard = false
        viewModel.shouldShowVideoPlayer = false
    }

    private func deleteItem(_ item: QuestionItem) {
        viewModel.delete(item: item)
    }
}

// MARK: - Glass Circle Button
private struct GlassCircleButton: View {
    let systemName: String
    var diameter: CGFloat = 48
    var baseBackground: Color
    var action: () -> Void

    private var fill: Color { Color.white.opacity(0.35) }
    private var rimHighlight: Color { Color.white.opacity(0.85) }
    private var innerShadow: Color { Color.black.opacity(0.08) }
    private var outerGlow: Color { Color.white.opacity(0.55) }
    private var iconColor: Color { Color.black.opacity(0.75) }

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.title3.weight(.semibold))
                .foregroundStyle(iconColor)
                .frame(width: diameter, height: diameter)
                .background(
                    ZStack {
                        fill.blur(radius: 0)
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.55), Color.white.opacity(0.20)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .opacity(0.6)
                        Circle()
                            .stroke(innerShadow, lineWidth: 1.0)
                            .blur(radius: 1.2)
                            .offset(x: 0, y: 1)
                            .mask(
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.black, Color.clear],
                                            startPoint: .bottom,
                                            endPoint: .top
                                        )
                                    )
                            )
                        Circle()
                            .stroke(rimHighlight, lineWidth: 1.2)
                            .blendMode(.plusLighter)
                            .opacity(0.9)
                    }
                )
                .background(
                    Circle()
                        .fill(outerGlow)
                        .blur(radius: 8)
                        .opacity(0.8)
                )
                .background(
                    Circle()
                        .fill(baseBackground.opacity(0.001))
                )
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
        .shadow(color: Color.white.opacity(0.5), radius: 12, x: -2, y: -2)
        .contentShape(Circle())
        .accessibilityLabel(Text(systemName == "plus" ? "إضافة" : "رجوع"))
    }
}

#Preview {
    QuestionView()
}
