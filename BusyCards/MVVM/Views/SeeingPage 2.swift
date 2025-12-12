




import SwiftUI
import AVKit

struct SeeingPage2: View {
    
    let url = Bundle.main.url(forResource: "numberVideo", withExtension: "MP4")
    
    var body: some View {
        ZStack{
            
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 90) {
                
                Image("GG1")
                
                if url != nil{
                    VideoPlayer(player: AVPlayer(url: url!))
                        .frame(width: 378,height: 211)
                        .border(Color.darkBlue,width: 7)
                }
                
                Button{
                    
                }label: {
                    ZStack{
                        Color.darkBlue
                            .frame(width: 260,height: 56)
                            .cornerRadius(15)
                        
                        Text("أنتهيت")
                            .font(.system(size: 25))
                            .foregroundStyle(Color.white)
                    }//z
                }//b
            }//v
        }//z
    }
}
#Preview {
    SeeingPage2()
}

