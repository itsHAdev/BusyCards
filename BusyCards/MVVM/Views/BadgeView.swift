//
//  BadgeView.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 11/12/2025.
//

import SwiftUI

struct BadgeView: View {
    var body: some View {
        
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            Color.white
                .frame(width: 304,height: 481)
                .cornerRadius(20)
            
            VStack{
                Image("AuditoryC")
                
                Text("أنت رائع")
                    .font(.system(size: 36))
                
                Spacer().frame(height: 9)
                
                Text("جائزتك تنتظرك")
                    .font(.system(size: 20) .weight(.light))
                    .foregroundStyle(Color.gray)
                    
                Spacer().frame(height: 30)
                
                Button{}label: {
                    ZStack{
                        Color.darkBlue
                            .frame(width: 250,height: 53)
                            .cornerRadius(16)
                        
                        Text("أذهب للجائزة")
                            .font(.system(size: 18))
                            .bold()
                            .foregroundStyle(Color.white)
                    }//z
                }//b
                
                Spacer().frame(height: 10)
                
                
                Button("إغلاق"){
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                
                .foregroundStyle(Color.darkBlue)
            }//v
        }//z
        
    }
}

#Preview {
    BadgeView()
}
