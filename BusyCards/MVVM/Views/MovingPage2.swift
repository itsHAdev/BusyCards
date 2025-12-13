//
//  MovingPage2.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 13/12/2025.
//

import SwiftUI
struct MovingPage2: View {
    
    @StateObject private var viewModel = QuestionsViewModel()
    @State private var question: QuestionItem?
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()

                VStack(spacing: 152) {
                    Image("KinestheticC")

                    Text(question?.title ?? "لا يوجد سؤال")
                        .font(.system(size: 34))
                        .multilineTextAlignment(.center)

                    if question != nil {
                        NavigationLink {
                            MovingPage()
                        } label: {
                            ZStack {
                                Color.darkBlue
                                    .frame(width: 260, height: 56)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black, radius: 3, x: 2, y: 2)

                                Text("اذهب للإجابة")
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 28))
                            }
                        }
                    }
                }
            }
        }//navS
        
        .onAppear {
            question = viewModel.randomQuestion()
        }
        
        
    }
}

#Preview {
    MovingPage2()
}
