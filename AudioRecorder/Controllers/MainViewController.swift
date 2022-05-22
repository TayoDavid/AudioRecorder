//
//  ViewController.swift
//  AudioRecorder
//
//  Created by Omotayo on 22/05/2022.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addFirstRecording: UIButton!
    @IBOutlet weak var dataTableView: UITableView!
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldSetupUserInterface()
    }

    func shouldSetupUserInterface() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "barTint")
        CoreDataService.shared.currentCoreData(state: .load)
        shouldSetupTableView()
    }
    
    func shouldSetupTableView() {
        dataTableView.backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        dataTableView.register(UINib(nibName: "RecordingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shouldHandleFirstRecordingButton()
        return CoreDataService.shared.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecordingTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor(named: "cellEven")
        } else {
            cell.contentView.backgroundColor = UIColor(named: "cellUnEven")
        }
        
        let currentObject = CoreDataService.shared.recordedData[indexPath.row]
        
        cell.titleLabel.text = currentObject.title
        cell.dateLabel.text = currentObject.date?.formatedDate()
        cell.playButtonClosure = { [unowned self] in
            do {
                self.player = try AVAudioPlayer(data: currentObject.audioData!)
                self.player?.play()
            } catch let error {
                print(error)
            }
        }
        
        return cell
    }
    
}
