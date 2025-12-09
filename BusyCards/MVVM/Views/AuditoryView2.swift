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

    var body: some View {
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
                        Color.darkBlue
                            .frame(width: 218, height: 218)
                            .cornerRadius(1000)

                        Color.darkBlue2
                            .frame(width: 145.21, height: 145.21)
                            .cornerRadius(1000)

                        Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(Color.white)
                    }
                }

                NavigationLink {
                    HomePage()
                        .navigationBarBackButtonHidden(true)
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
            }
        }
        .onDisappear {
            stopAudio()
        }
    }

    private func playAudio() {
        guard let mp3FileName = question.mp3FileName else { return }
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(mp3FileName)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = AVDelegate(isPlaying: $isPlaying)
            player?.play()
            isPlaying = true
        } catch {
            print("Error playing MP3: \(error.localizedDescription)")
        }
    }

    private func stopAudio() {
        player?.stop()
        player = nil
        isPlaying = false
    }
}

// Delegate class to reset isPlaying when audio finishes
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
    AuditoryView2(question: QuestionItem(id: UUID(), title: "Title", link: nil, mp3FileName: "test.mp3"))
}
