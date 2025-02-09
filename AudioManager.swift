//
//  AudioManager.swift
//  JambhekarMedhavi-Final
//
//  Created by Medhavi Jam on 12/8/24.
//

import AVFoundation

class AudioManager {
    static let shared = AudioManager() 
    private var player: AVAudioPlayer?
    private var isMusicPlaying = false

    private init() {}


    func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }


    func playAudio(named fileName: String) {
        if !isMusicPlaying, let audioPath = Bundle.main.path(forResource: fileName, ofType: "mp3") {
            let audioURL = URL(fileURLWithPath: audioPath)
            do {
             
                player = try AVAudioPlayer(contentsOf: audioURL)
                player?.numberOfLoops = -1
                player?.play()
                isMusicPlaying = true
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        }
    }


    func pauseAudio() {
        player?.pause()
        isMusicPlaying = false
    }


    func stopAudio() {
        player?.stop()
        player = nil
        isMusicPlaying = false
    }


    func toggleMusic(named fileName: String) {
        if isMusicPlaying {
            pauseAudio()
        } else {
            playAudio(named: fileName)
        }
    }
}


