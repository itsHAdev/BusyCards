//
//  ContentView2.swift
//  BusyCards
//
//  Created by Athoub Alabdulrahim on 11/06/1447 AH.
//

import SwiftUI

struct HomePage: View {
    @State private var showSheet = false
    @StateObject private var viewModel = ContentViewModel()
    @State private var showStudentsList = false
    @StateObject var childrenVM = ChildrenViewModel()
    @State private var selectedChildType: String? = nil
    @State private var navigateToLearning = false

    // Color assets
    private let beigeBackground = Color("Background")
    private let deepDarkBlue = Color("DarkBlue")

    
    var body: some View {
        NavigationStack {

            ZStack(alignment: .topTrailing) {
                NavigationLink(
                    isActive: $navigateToLearning
                ) {
                    destinationView()
                } label: {
                    EmptyView()
                }
                .hidden()

                beigeBackground
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    GeometryReader { geo in
                        let screenCenter = geo.size.width / 2

                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack(spacing: -160) {
                                ForEach(viewModel.cards) { card in

                                    NavigationLink(destination: card.destination) {

                                        GeometryReader { itemGeo in
                                            let itemCenter = itemGeo.frame(in: .global).midX
                                            let distance = abs(screenCenter - itemCenter)

                                            let scale = max(0.70, 1 - (distance / 450))

                                            cardImage(card.imageName)
                                                .scaleEffect(scale)
                                                .animation(.spring(response: 0.4,
                                                                   dampingFraction: 0.7),
                                                           value: scale)
                                        }
                                        .frame(width: 400, height: 480)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, (geo.size.width - 270) / 2)
                        }
                    }
                    .frame(height: 500)

                   
                    NavigationLink(destination: SurveyView().environmentObject(childrenVM)) {
                        Text("ابدأ الاختبار")
                            .font(.title2.weight(.semibold))
                            .frame(maxWidth: 250, minHeight: 56)
                            .background(deepDarkBlue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.bottom, 60)
                    .padding(.top, 40)
                }

                // MARK: - Top Buttons
                HStack(spacing: 12) {

                    NavigationLink(destination: QuestionView()) {
                        glassButton(icon: "plus")
                    }
                    .buttonStyle(.plain)

                    Button {
                        // Present the students list sheet
                        showStudentsList = true
                    } label: {
                        glassButton(icon: "list.dash")
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 10)
                .padding(.trailing, 15)
            }
            // Attach the sheet to a stable ancestor (the ZStack)
            .sheet(isPresented: $showStudentsList) {
                StudentsListView(
                    onSelect: { type in
                        selectedChildType = type
                        showStudentsList = false

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            navigateToLearning = true
                        }
                    }
                )
                .presentationDetents([.fraction(0.90)])
                .presentationDragIndicator(.visible)
                .presentationBackground(.clear)
                .environmentObject(childrenVM)
                .presentationCornerRadius(28)
            }

        }
    }

    // MARK: - Card Image
    private func cardImage(_ name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 410, height: 500)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
    }

    // MARK: - Glass Button
    private func glassButton(icon: String) -> some View {
        ZStack {
            Circle()
                .fill(beigeBackground.opacity(0.50))
                .background(.ultraThinMaterial)
                .frame(width: 50, height: 50)
                .cornerRadius(40)
                .glassEffect()

            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black.opacity(0.99))
        }
    }
    @ViewBuilder
    private func destinationView() -> some View {
        switch selectedChildType {
        case "سمعي":
            AuditoryView()
        case "بصري":
            SeeingPage()
        case "حركي":
            MovingPage2()
        case "قرائي/كتابي":
            Text("واجهة القرائي/الكتابي")
        default:
            EmptyView()
        }
    }
}
#Preview {
    HomePage()
}
