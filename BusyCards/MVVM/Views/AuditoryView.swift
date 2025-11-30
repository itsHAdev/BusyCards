//
//  AuditoryView.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 30/11/2025.
//

import SwiftUI

struct AuditoryView: View {
    var body: some View {
        
        ZStack{
            
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 75){
                
                Image("Auditory2")
                
                
                Button{}label: {
                    
                    ZStack{
                    Color.darkBlue
                        .frame(width: 240,height: 244)
                        .cornerRadius(300)
                        .shadow(color: Color.black , radius: 4, x:2 ,y: 2)
                        
                        Color.darkBlue
                            .frame(width: 240,height: 244)
                            .cornerRadius(300)
                            .shadow(color: Color.black , radius: 4, x:-1.6 ,y: -1.6)
                        
                        Color.darkBlue
                            .frame(width: 221,height: 225)
                            .cornerRadius(300)
                            .opacity(0.6)
                            .shadow(color: Color.black , radius: 5, x:2 ,y: 2)
                        
                        Image(systemName:"play.fill")
                            .font(.system(size: 100))
                            .foregroundStyle(Color.white)
                }//z
                }//b
                
                Button{}label: {
                    
                    ZStack{
                        
                        Color.darkBlue
                            .frame(width: 260,height: 56)
                            .cornerRadius(15)
                            .shadow(color: Color.black, radius: 3,x: 2,y: 2)
                        
                        Text("انتهيت")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 28))
                        
                    }//z
                }//b
            }//v
            
        }//z
    }
}

#Preview {
    AuditoryView()
}
