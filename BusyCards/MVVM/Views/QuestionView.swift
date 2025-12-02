import SwiftUI

struct QuestionView: View {
    @StateObject private var viewModel = QuestionsViewModel()
    @State private var showingAddCard = false
    @State private var newTitle: String = ""
    @FocusState private var isFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss

    // Base background color (same as screen) to help the glass effect blend
    private let baseBg = Color(red: 0.96, green: 0.90, blue: 0.90)

    var body: some View {
        NavigationStack {
            ZStack {
                // Background color similar to the screenshot
                baseBg
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Header occupies fixed vertical space; content will be below it
                    header
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 12)

                    // Content area starts here (under the icons)
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
                                .swipeActions(edge: .leading) {   // السحب من اليسار
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

                    // Floating add card overlay
                    if showingAddCard {
                        // Dimmed backdrop (tap to dismiss)
                        Color.black.opacity(0.15)
                            .ignoresSafeArea()
                            .transition(.opacity)
                            .onTapGesture { cancelAdd() }

                        addCard
                            .transition(.asymmetric(
                                insertion: .scale(scale: 0.95).combined(with: .opacity),
                                removal: .opacity
                                
                            ))
                            .padding(.horizontal, 24)
                    }
                }
            }
            .animation(.spring(response: 0.35, dampingFraction: 0.9), value: showingAddCard)
            .navigationBarHidden(true)
        }
        .environment(\.layoutDirection, .rightToLeft) // RTL for the whole screen
        .task {
            await viewModel.loadSampleIfNeeded()
        }
    }

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
                    }
                }

                Spacer()

                // BACK on the left (last in RTL HStack)
                GlassCircleButton(
                    systemName: "chevron.left",
                    diameter: 48,
                    baseBackground: baseBg
                ) {
                    dismiss()
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 64, alignment: .center)
        .padding(.horizontal, 4)
    }

    // MARK: - Add Card UI
    private var addCard: some View {
        VStack(alignment: .trailing, spacing: 16) {
            Text("أضف سؤال")
               .font(.custom("SF Arabic Rounded", size: 20))
               .frame(maxWidth: .infinity, alignment: .leading)

            
            TextField("سؤال", text: $newTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .focused($isFieldFocused)
                .textInputAutocapitalization(.sentences)
                .submitLabel(.done)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Capsule().fill(Color(.systemGray6)))
                .font(.custom("SF Arabic Rounded", size: 20))

            HStack(spacing: 16) {
                Button(action: cancelAdd) {
                    Text("إلغاء")
                        .font(.custom("SF Arabic Rounded", size: 20))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Capsule().fill(Color(.systemGray6)))
                }

                Button(action: saveAdd) {
                    Text("حفظ")
                        .font(.custom("SF Arabic Rounded", size: 20))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Capsule().fill(Color(.systemGray6)))
                }
                .disabled(newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 8)
        )
    }

    // MARK: - Actions
    private func saveAdd() {
        let trimmed = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        viewModel.add(title: trimmed)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        newTitle = ""
        isFieldFocused = false
        showingAddCard = false
    }

    private func cancelAdd() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        newTitle = ""
        isFieldFocused = false
        showingAddCard = false
    }

    private func delete(at offsets: IndexSet) {
        viewModel.delete(at: offsets)
    }

    private func deleteItem(_ item: QuestionItem) {
        viewModel.delete(item: item)
    }
}

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
