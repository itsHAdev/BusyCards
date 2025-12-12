




import SwiftUI
import AVKit

struct SeeingPage2: View {
    
    let url = Bundle.main.url(forResource: "number2Video", withExtension: "MP4")
    
    @State private var showBadge = false
    @State private var goReward = false
    
    var body: some View {
        NavigationStack{
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
                        showBadge = true
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
                //MARK: - Badge
                    
                    if showBadge {
                        ZStack {
                
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()

                            VStack {
                                Color.white
                                    .frame(width: 304, height: 481)
                                    .cornerRadius(20)
                                
                                    .overlay(
                                        VStack {
                                            Image("VisualC")

                                            Text("أنت رائع")
                                                .font(.system(size: 36))

                                            Spacer().frame(height: 9)

                                            Text("جائزتك تنتظرك")
                                                .font(.system(size: 20).weight(.light))
                                                .foregroundStyle(Color.gray)

                                            Spacer().frame(height: 30)

                                            Button {
                                                goReward = true
                                            } label: {
                                                ZStack {
                                                    Color.darkBlue
                                                        .frame(width: 250, height: 53)
                                                        .cornerRadius(16)

                                                    Text("أذهب للجائزة")
                                                        .font(.system(size: 18))
                                                        .bold()
                                                        .foregroundStyle(Color.white)
                                                }//z
                                            }//b

                                            Spacer().frame(height: 10)

                                            Button("إغلاق") {
                                                showBadge = false
                                            }//b
                                            .foregroundStyle(Color.darkBlue)

                                        }//v
                                    )//overlay
                            }//v
                        }//z
                    }//ShowBadge

                    
                    NavigationLink("", destination: SeeingReward(), isActive: $goReward)
                                    .hidden()
            }//z
        }//navS
    }
}
#Preview {
    SeeingPage2()
}

