// QuestionView.swift (المُعدّل)

import SwiftUI

struct QuestionView: View {
    @StateObject private var viewModel = QuestionsViewModel()
    @State private var showingAddCard = false
    @State private var newTitle: String = ""
    @State private var newLink: String = ""
    @FocusState private var isFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    // Base background color (same as screen) to help the glass effect blend
    private let baseBg = Color(red: 0.96, green: 0.90, blue: 0.90)

    var body: some View {
        ZStack {
            // Background color similar to the screenshot
            baseBg
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // ... (Header and List content remain the same) ...
                header
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 12)

                List {
                    ForEach(viewModel.items) { item in
                        Text(item.title)
                            .font(.custom("SF Arabic Rounded", size: 22)) // bigger text
                            .lineLimit(nil)
                            .lineSpacing(4) // more line spacing for multi-line titles
                            .frame(maxWidth: .infinity, alignment: .leading) // محاذاة النص لليمين
                            .padding(.vertical, 14) // taller rows
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)) // use almost full width
                            .listRowBackground(Color.clear)
                            .swipeActions(edge: .leading) { // السحب من اليسار
                                Button(role: .destructive) {
                                    deleteItem(item)
                                } label: {
                                    Text("حذف")
                                }
                            }
                    }
                }
                .environment(\.layoutDirection, .rightToLeft) // Ensure the List itself is RTL
                .scrollContentBackground(.hidden) // remove List's default background
                .listStyle(.plain)
                .listRowSeparator(.hidden) // hide separators
                .safeAreaPadding(.top, 4)
            }

            // Floating add card overlay
            if showingAddCard {
                ZStack {
                    // Dimmed backdrop (tap to dismiss)
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
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.9), value: showingAddCard)
        .environment(\.layoutDirection, .rightToLeft)
        
        // ✅ إضافة fullScreenCover للتحكم في ظهور صفحة الفيديو
        .fullScreenCover(isPresented: $viewModel.shouldShowVideoPlayer) {
            // نستخدم المعرّف المستخرج من الـ ViewModel
            if let videoID = viewModel.extractedVideoID {
                SeeingPage2(videoID: videoID)
            } else {
                // هذا الجزء لن يظهر أبداً طالما أن shouldShowVideoPlayer=true، ولكن للحماية
                Text("خطأ في تحميل الفيديو")
            }
        }
    }
    
    // ... (private var header: some View remains the same) ...
    private var header: some View {
        ZStack {
            Text("أسئلة اليوم")
                .font(.custom("SF Arabic Rounded", size: 25))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)

            HStack {
                // PLUS on the right (first in RTL HStack)
                GlassCircleButton(
                    systemName: "plus",
                    diameter: 48,
                    baseBackground: baseBg
                ) {
                    showingAddCard.toggle()
                    if showingAddCard {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            isFieldFocused = true
                        }
                    } else {
                        isFieldFocused = false
                        newTitle = ""
                        newLink = ""
                    }
                }

                Spacer()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 64, alignment: .center)
        .padding(.horizontal, 4)
    }

    // MARK: - Add Card UI (remains the same)
    private var addCard: some View {
        VStack(alignment: .trailing, spacing: 20) {
            // العنوان الأول
            Text("أضف سؤال")
                .font(.custom("SF Arabic Rounded", size: 26).weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

            // حقل السؤال
            TextField("سؤال", text: $newTitle)
                .focused($isFieldFocused)
                .textInputAutocapitalization(.sentences)
                .submitLabel(.done)
                .padding(.horizontal, 20)
                .padding(.vertical, 18)
                .background(Capsule().fill(Color(.systemGray6)))
                .font(.custom("SF Arabic Rounded", size: 22))
                .foregroundStyle(.primary)

            // العنوان الثاني
            Text("أضف رابط الإجابة")
                .font(.custom("SF Arabic Rounded", size: 26).weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 4)

            // حقل الرابط
            TextField("رابط", text: $newLink)
                .keyboardType(.URL)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .padding(.horizontal, 20)
                .padding(.vertical, 18)
                .background(Capsule().fill(Color(.systemGray6)))
                .font(.custom("SF Arabic Rounded", size: 22))
                .foregroundStyle(.primary)

            // النص الإرشادي
            Text("تأكد من إمكانية عمل الرابط لك فيديو أو صوت.")
                .font(.custom("SF Arabic Rounded", size: 20))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
                .padding(.top, 2)

            // الأزرار
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
    }

    // MARK: - Actions (Modified)
    private func saveAdd() {
        let trimmedTitle = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }
        
        // ✅ استخدام الدالة الجديدة التي تعالج الرابط
        viewModel.processAndSave(title: trimmedTitle, link: newLink)
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        // مسح الحقول وإخفاء البطاقة
        newTitle = ""
        newLink = ""
        isFieldFocused = false
        showingAddCard = false
    }

    private func cancelAdd() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        newTitle = ""
        newLink = ""
        isFieldFocused = false
        showingAddCard = false
        // ✅ التأكد من إعادة ضبط حالة الانتقال في حال كانت مفعّلة
        viewModel.shouldShowVideoPlayer = false
    }

    private func deleteItem(_ item: QuestionItem) {
        viewModel.delete(item: item)
    }
}
// ... (private struct GlassCircleButton remains the same) ...

private struct GlassCircleButton: View {
    let systemName: String
    var diameter: CGFloat = 48
    var baseBackground: Color
    var action: () -> Void

    // Colors tuned for the rose background to get a soft glass look
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
