//
//  RecorderViewController.swift
//  AudioRecorder
//
//  Created by Omotayo on 22/05/2022.
//

import UIKit
import AVFoundation

enum RecordingState {
    case start, stop
}

protocol UpdateRecordingsDelegate {
    func updateRecordingsTableView()
}

class RecorderViewController: UIViewController {

    @IBOutlet weak var recorderLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    var delegate: UpdateRecordingsDelegate?
    
    private var recordingState: RecordingState = .start
    
    private var stopButtonWasTapped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recorderLabel.text = "Tap button to start."
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if recordingState == .stop && !stopButtonWasTapped {
            shouldStopAndSaveRecording()
        }
    }

    @IBAction func didTapRecordButton(_ sender: UIButton) {
        switch recordingState {
            case .start: shouldStartRecording()
            case .stop:
                stopButtonWasTapped = true
                shouldStopAndSaveRecording()
        }
    }
    
    func shouldStartRecording() {
            
        switch AVAudioSession.sharedInstance().recordPermission {
            case .undetermined: AVAudioSession.sharedInstance().requestRecordPermission { _ in
                
            }
            case .denied: recorderLabel.text = "Microphone access was denied"
            case .granted: break
            @unknown default: break
        }
        
        _ = AudioRecorder.shared.shouldManageRecording(.started)
        recordingState = .stop
        recordButton.shouldSetupSFSymbol(imageName: "stop.fill", fontSize: 100)
        recorderLabel.text = "Recording"
    }
    
    func shouldStopAndSaveRecording() {
        let recordedObject = Recorded(context: CoreDataService.shared.appViewContext())
        recordedObject.title = "Recording \(CoreDataService.shared.numberOfItems())"
        recordedObject.date = Date()
        recordedObject.audioData = AudioRecorder.shared.shouldManageRecording(.ended)
        CoreDataService.shared.currentCoreData(state: .save)
        
        // Remove Audio Recorder from memory
        AudioRecorder.shared.shouldDeinitialize()
        
        delegate?.updateRecordingsTableView()
        
        dismiss(animated: true, completion: nil)
    }
}
