//
//  OnboardingView1.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 02/12/2025.
//

import SwiftUI

struct OnboardingView1: View {
    
    var body: some View {
        
        ZStack{
            
            Color.lightGray
                .ignoresSafeArea()
            
            Image("iphone1")
                .frame(width: 330,height: 730)
                .padding(.top,150)
            
            
            Color.white
            
                .frame(width: 402,height: 621)
                .padding(.top,230)
            
            VStack(spacing: 17){
                Text("أسئلة الطفل اليومية")
                    .font(.system(size: 28))
                    .fontWeight(.medium)
                
                
                Text("يمكنك عبر هذا الزر إضافة الأسئلة التي ترغب بها ليتم عرضها بشكل عشوائي للطفل داخل الـ Busy Cards هذه الأسئلة تساعد على إثراء تجربة التعلم وجعلها أكثر تفاعل.")
                    .frame(width: 322,height: 100)
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
    OnboardingView1()
}
