//
//  AuditoryReward.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 11/12/2025.
//

import SwiftUI

struct AuditoryReward: View {
    var body: some View {
        
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            VStack{
                Text("شاهد الفيديو وعندما تسمع تجميد توقف عن الحركة وعندما تسمع استمر اكمل الحركة")
                    .frame(width: 334,height: 105)
                    .font(.system(size: 28))
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 35)
                
                Color.darkBlue
                    .frame(width: 378,height: 211)
                
               Spacer().frame(height: 197)
                
                Button{}label: {
                    ZStack{
                        Color.darkBlue
                            .frame(width: 260,height: 56)
                            .cornerRadius(15)
                        
                        Text("أنتهيت")
                            .font(.system(size: 25))
                            .foregroundStyle(Color.white)
                        
                    }//z
                    //.padding(.bottom)
                }//b
                
            }//v
        }//z
    }
}

#Preview {
    AuditoryReward()
}
