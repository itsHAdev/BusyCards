//
//  AuditoryView.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 30/11/2025.
//
import SwiftUI

struct AuditoryView: View {
    @StateObject private var viewModel = QuestionsViewModel()
    @State private var question: QuestionItem?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()

                VStack(spacing: 152) {
                    Image("Auditory2")

                    Text(question?.title ?? "لا يوجد سؤال")
                        .font(.system(size: 34))
                        .multilineTextAlignment(.center)

                    if question != nil {
                        NavigationLink {
                            AuditoryView2(question: question!)
                        } label: {
                            ZStack {
                                Color.darkBlue
                                    .frame(width: 260, height: 56)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black, radius: 3, x: 2, y: 2)

                                Text("استمع للإجابة")
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 28))
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            question = viewModel.randomQuestion()
        }
    }
}
#Preview {
    AuditoryView()
}

