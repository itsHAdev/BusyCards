//
//  AuditoryReward.swift
//  BusyCards
//
//  Created by Hadeel Alansari on 11/12/2025.
//

import SwiftUI
import AVKit

struct AuditoryReward: View {
    
    let url = Bundle.main.url(forResource: "FloorIsLava", withExtension: "MP4")
    
    var body: some View {
        
        ZStack{
            Color.background
                .ignoresSafeArea()
            
            VStack{
                Text("شاهد الفيديو وعندما تسمع تجميد توقف عن الرقص وعندما تسمع استمر اكمل الرقص")
                    .frame(width: 334,height: 105)
                    .font(.system(size: 28))
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 100)
                
                
                    
                    if url != nil{
                        VideoPlayer(player: AVPlayer(url: url! ))
                            .frame(width: 378,height: 211)
                            .border(Color.darkBlue,width: 7)
                    }
                 
              Spacer().frame(height: 198)
                
                
                
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
