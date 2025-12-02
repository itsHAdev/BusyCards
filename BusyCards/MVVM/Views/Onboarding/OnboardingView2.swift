//
//  OnboardingView2.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 02/12/2025.
//

import SwiftUI

struct OnboardingView2: View {
    var body: some View {
        
        ZStack{
            
            Color.grayApp
                .ignoresSafeArea()
            
            Image("iphone2")
                .frame(width: 330,height: 730)
                .padding(.top,150)
            
            
            Image(systemName: "arrow.up.right")
                .font(.system(size: 50))
                .fontWeight(.light)
                .offset(x: 60,y: -235)
            
            
            Color.white
            
                .frame(width: 402,height: 621)
                .padding(.top,230)
            
            VStack(spacing: 17){
                Text("قائمة الأطفال وأنماط التعلم")
                    .font(.system(size: 28))
                    .fontWeight(.medium)
                
                
                Text("من هنا يمكن مشاهدة أسماء الأطفال والتعرف على نمط التعلم الخاص بكل طفل و هذا يساعد على فهم أسلوب الطفل وتسهيل متابعة التقدم.")
                    .frame(width: 342,height: 100)
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
                        
                        Text("التالي")
                            .font(.system(size: 28))
                            .foregroundStyle(Color.white)
                        
                    }//z
                }//b
                .padding(.top,630)
                
                Button{}label: {
                    VStack{
                        
                        Text("تخطي الارشادات")
                            .font(.system(size: 22))
                            .foregroundStyle(Color.darkBlue)
                        
                    }//v
                }//b
                
            }//v
        }//z

    }
}

#Preview {
    OnboardingView2()
}
