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

                    // السؤال
                    Text(question?.title ?? "لا يوجد سؤال")
                        .font(.system(size: 34))
                        .multilineTextAlignment(.center)
                        .padding()

                    // زر الاستماع (نفسه بدون تحديث السؤال)
                    NavigationLink {
                        AuditoryView2()
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
                } // VStack
            } // ZStack
        }
        .onAppear {
            // اختار سؤال عشوائي لو فيه أسئلة، وإلا يظل nil
            question = viewModel.randomQuestion()
        }
    }
}

#Preview {
    AuditoryView()
}


import SwiftUI

struct AuditoryView2: View {
  
    var body: some View {
       
            
            ZStack{
                
                Color.background
                    .ignoresSafeArea()
                
                VStack(spacing: 68){
                    
                    Image("Auditory2")
                    
                    Button{
                        
                    }label: {
                        
                        ZStack{
                            
                            Color.darkBlue
                                .frame(width: 218,height: 218)
                                .cornerRadius(1000)
                            
                            Color.darkBlue2
                                .frame(width: 145.21,height: 145.21)
                                .cornerRadius(1000)
                            
                            Image(systemName:"play.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(Color.white)
                        }//z
                    }
                    
                    NavigationLink {
                        HomePage()
                        
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        ZStack {
                            Color.darkBlue
                                .frame(width: 260, height: 56)
                                .cornerRadius(15)
                                .shadow(color: Color.black, radius: 3, x: 2, y: 2)
                            
                            Text("انتهيت")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 28))
                        }
                    }//b
                    
                }//v
            }//z
    }
}
