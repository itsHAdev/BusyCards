//
//  OnboardingView3.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 02/12/2025.
//

import SwiftUI

struct OnboardingView3: View {
    @State private var goNext = false
    var body: some View {
        NavigationStack{
            ZStack{
                
                Color.grayApp
                    .ignoresSafeArea()
                
                Image("iphone3")
                    .frame(width: 330,height: 730)
                    .padding(.top,-998)
                
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 50))
                    .fontWeight(.light)
                    .offset(x: -145,y: -255)
                
                Color.white
                
                    .frame(width: 402,height: 621)
                    .padding(.top,230)
                
                VStack(spacing: 20){
                    Text("اختبار تحديد نمط التعلم")
                        .font(.system(size: 28))
                        .fontWeight(.medium)
                    
                    
                    Text("من هنا يمكن بدا الاختبار لمعرفة نمط تعلم الطفل.")
                        .frame(width: 302,height: 100)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 20))
                        .fontWeight(.light)
                }//v
                
                VStack(spacing: 22){
                    Button{}label: {
                        ZStack{
                            
                            Color.darkBlue
                                .frame(width: 260,height: 56)
                                .cornerRadius(15)
                            
                            Text("ابدأ")
                                .font(.system(size: 28))
                                .foregroundStyle(Color.white)
                            
                        }//z
                    }//b
                    .padding(.top,630)
                    
                    Button{}label: {
                        VStack{
                            
                            Text("تخطي الارشادات")
                                .font(.system(size: 15))
                                .foregroundStyle(Color.darkBlue)
                            
                        }//v
                    }//b
                    
                }//v
            }//z
            
            .navigationBarBackButtonHidden(true)
        }//nav

    }
}

#Preview {
    OnboardingView3()
}
