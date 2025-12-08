//
//  SurveyView.swift
//  BusyCards
//
//  Created by Fai Altayeb on 01/12/2025.
//
import SwiftUI

struct SurveyView: View {
    @StateObject private var viewModel = SurveyViewModel()
    @EnvironmentObject var childrenVM: ChildrenViewModel
    
    @State private var showNamePopup = false
    @State private var showResultPopup = false
    
    @State private var studentName = ""
    @State private var finalResult = ""
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack(spacing: 80){
                
                progressBar
                    //.padding(.top, 20)
                
                VStack (spacing: 80){
                    
                    // Spacer().frame(height: 50)
                    
                    
                    
                    // Spacer().frame(height: 50)
                    
                    Text(viewModel.questions[viewModel.currentIndex].questions)
                        .font(.custom("SF Arabic Rounded", size: 24))
                        .multilineTextAlignment(.trailing)
                        .padding(.horizontal, 20)
                    
                    VStack {
                        //Spacer()
                        
                        
                        // Spacer().frame(height: 50)
                        
                        VStack(spacing: 16) {
                            ForEach(viewModel.questions[viewModel.currentIndex].options, id: \.self) { option in
                                optionButton(option)
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        //Spacer()
                    }
                    
                    
                    //Spacer()
                    
                    
                    Button(action: {
                        if viewModel.selectedOptions[viewModel.questions[viewModel.currentIndex].id] == nil {
                            return
                        }
                        
                        if viewModel.isLastQuestion {
                            finalResult = viewModel.calculateResult()
                            showNamePopup = true
                            
                            
                        } else {
                            viewModel.nextQuestion()
                        }
                    }) {
                        
                        //Spacer().frame(height: 50)
                        
                        Text("التالي")
                            .font(.custom("SF Arabic Rounded", size: 20))
                            .foregroundColor(.white)
                            .frame(width: 334, height: 50)
                            .background(Color.darkBlue)
                            .cornerRadius(14)
                            .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
                    }
                    //.padding(.bottom, 30)
                }
            }
        }
        
        
        .alert(
            "أدخل اسم الطالب",
            isPresented: $showNamePopup,
            presenting: (),
            actions: { _ in
                TextField("الاسم", text: $studentName)
                
                Button("متابعة") {
                    finalResult = viewModel.calculateResult()

                    let trimmed = studentName.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !trimmed.isEmpty {
                        childrenVM.addChild(name: trimmed, type: finalResult)
                    }
                    showResultPopup = true
                }
                Button("إلغاء") {
                    showNamePopup = false
                }
            },
            message: { _ in
                EmptyView()
            }
        )
        
        .alert("النتيجة النهائية", isPresented: $showResultPopup) {
            Button("حسناً") {}
        } message: {
            Text("نوع التعلم: \(finalResult)")
        }
    }
    
    
   
    private func optionButton(_ option: String) -> some View {
        let questionID = viewModel.questions[viewModel.currentIndex].id
        let isSelected = viewModel.selectedOptions[questionID] == option
        
        return Button {
            viewModel.choose(option)
        } label: {
            Text(option)
                .font(.custom("SF Arabic Rounded", size: 18))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isSelected ? Color.darkBlue.opacity(0.2) : Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
        }
    }
    
    
 
    private var progressBar: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let progress = CGFloat(viewModel.currentIndex + 1) / CGFloat(viewModel.questions.count)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 6)
                
                Capsule()
                    .fill(Color.darkBlue)
                    .frame(width: width * progress, height: 6)
            }
        }
        .frame(height: 6)
        .padding(.horizontal, 40)
        .animation(.easeInOut(duration: 0.3), value: viewModel.currentIndex)
    }
    
   
    }


#Preview {
    SurveyView()
    
}
