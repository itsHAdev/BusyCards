//
//  OnboardingView3.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 02/12/2025.
//

import SwiftUI

struct OnboardingView3: View {
    var body: some View {
        
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
            
            VStack(spacing: 17){
                Text("اختبار تحديد نمط التعلم")
                    .font(.system(size: 28))
                    .fontWeight(.medium)
                
                
                Text("يفتح هذا الزر اختبار يساعد على معرفة نمط تعلم الطفل بعد إكمال الاختبار يظهر النوع المناسب لكل طفل لتسهيل متابعة تعلمه بطريقة فعالة.")
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
    OnboardingView3()
}
