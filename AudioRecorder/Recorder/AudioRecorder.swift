//
//  AudioRecorder.swift
//  AudioRecorder
//
//  Created by Omotayo on 22/05/2022.
//

import UIKit
import AVFoundation

enum AudioRecorderState {
    case started, ended
}

class AudioRecorder {
    
    private struct Static {
        static var instance: AudioRecorder?
    }
    
    class var shared: AudioRecorder {
        if Static.instance == nil {
            Static.instance = AudioRecorder()
        }
        return Static.instance!
    }
    
    private var audioRecorder: AVAudioRecorder!
    
    var recordingSettings: [String: Int] = [
        AVSampleRateKey: 12000,
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVNumberOfChannelsKey: 2,
        AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
    ]
    
    private var recordingSession: AVAudioSession?
    
    private var recordedTrack: Data?
    
    private init() {
        shouldSetupAudioRecorder()
    }
    
    func shouldDeinitialize() {
        Static.instance = nil
    }
    
    private func shouldSetupAudioRecorder() {
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession?.setCategory(.playAndRecord, mode: .spokenAudio, options: .defaultToSpeaker)
            try audioRecorder = AVAudioRecorder(url: recordingsUrl(), settings: recordingSettings)
        } catch let error {
            print(error)
        }
        
    }
    
    private func recordingsUrl() -> URL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        
        documentDirectory.removeAllCachedResourceValues()
        
        let recordingsUrl = documentDirectory.appendingPathComponent("audio")
        
        return recordingsUrl!
    }
    
    private func startRecording() {
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            
            if let recordingSession = recordingSession {
                try recordingSession.setActive(true)
                audioRecorder.record()
            }
            
        } catch let error {
            print(error)
        }
        
    }
    
    private func stopRecording() {
        
        audioRecorder.stop()
        
        do {
            
            if let recordingSession = recordingSession {
                try recordingSession.setActive(false)
            }
            
        } catch let error {
            print(error)
        }
        
        var audioTrack: Data?
        
        do {
            audioTrack = try Data(contentsOf: audioRecorder.url)
        } catch let error {
            print(error)
        }
        
        if let audioTrack = audioTrack {
            recordedTrack = audioTrack
        }
    }
    
    func shouldManageRecording(_ state: AudioRecorderState) -> Data? {
        
        switch state {
            case .started:
                startRecording()
                return nil
            case .ended:
                stopRecording()
                return recordedTrack
        }
    }
    
}
