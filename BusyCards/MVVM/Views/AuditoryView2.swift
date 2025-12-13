//
//  AuditoryView2.swift
//  BusyCards
//
//  Created by Athoub Alabdulrahim on 18/06/1447 AH.
//

import SwiftUI
import AVFoundation

struct AuditoryView2: View {
    let question: QuestionItem
    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false
    
    @State private var showBadge = false
    @State private var goReward = false

    // Pulse animation state
    @State private var pulse = false

    var body: some View {
        NavigationStack{
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack(spacing: 68) {
                    Image("Auditory2")
                    
                    Button {
                        if isPlaying {
                            stopAudio()
                        } else {
                            playAudio()
                        }
                    } label: {
                        ZStack {
                            // Outer pulsing circle
                            Color.darkBlue
                                .frame(width: 218, height: 218)
                                .cornerRadius(1000)
                                .scaleEffect(isPlaying ? (pulse ? 1.08 : 0.95) : 1.0)
                                .animation(
                                    isPlaying ?
                                    .easeInOut(duration: 1.2).repeatForever(autoreverses: true) :
                                    .default,
                                    value: pulse
                                )

                            // Inner static circle
                            Color.darkBlue2
                                .frame(width: 145.21, height: 145.21)
                                .cornerRadius(1000)

                            // Play → Pause icon
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(Color.white)
                                .animation(.easeInOut(duration: 0.25), value: isPlaying)
                        }
                    }
                    
                    Button {
                        showBadge = true
                    } label: {
                        ZStack {
                            Color.darkBlue
                                .frame(width: 260, height: 56)
                                .cornerRadius(15)
                                .shadow(color: Color.black, radius: 3, x: 2, y: 2)
                            
                            Text("انتهيت")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 28))
                        }
                    }
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
                                        Image("AuditoryC")

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

                
                NavigationLink("", destination: AuditoryReward(), isActive: $goReward)
                                .hidden()


                
            }//z
       
        .onDisappear {
            stopAudio()
        }
        .onChange(of: isPlaying) { playing in
            // Start pulse animation when audio plays
            if playing {
                pulse = true
            } else {
                pulse = false
            }
        }
    }//navS
    }

    // MARK: - Play from Bundle
    private func playAudio() {
        guard let url = Bundle.main.url(forResource: "2TimesTableSong", withExtension: "mpeg") else {
            print("❌ Could not find 2TimesTableSong.mp3 in bundle")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = AVDelegate(isPlaying: $isPlaying)
            player?.play()
            isPlaying = true
        } catch {
            print("❌ Error playing sound: \(error.localizedDescription)")
        }
    }

    private func stopAudio() {
        player?.stop()
        player = nil
        isPlaying = false
    }
}

// MARK: - Delegate
private class AVDelegate: NSObject, AVAudioPlayerDelegate {
    @Binding var isPlaying: Bool

    init(isPlaying: Binding<Bool>) {
        self._isPlaying = isPlaying
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
}

#Preview {
    AuditoryView2(
        question: QuestionItem(
            id: UUID(),
            title: "Title",
            link: nil,
            mp3FileName: "2TimesTableSong.mp3"
        )
    )
}
