//
//  MainViewControllerExtension.swift
//  AudioRecorder
//
//  Created by Omotayo on 22/05/2022.
//

import UIKit

extension MainViewController {
    
    func shouldHandleFirstRecordingButton() {
        
        if CoreDataService.shared.numberOfItems() == 0 {
            
            addFirstRecording.shouldSetupSFSymbol(imageName: "plus", fontSize: 50)
            addFirstRecording.addTarget(self, action: #selector(didTapFirstRecordingButton), for: .touchUpInside)
            addFirstRecording.alpha = .zero
            addFirstRecording.transform = CGAffineTransform(translationX: .zero, y: 30)
            
            dataTableView.isHidden = true
            
            UIView.animate(withDuration: 1.0, delay: .zero, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.25, options: .curveEaseOut, animations: {
                
                self.addFirstRecording.isHidden = false
                self.addFirstRecording.transform = CGAffineTransform(translationX: .zero, y: .zero)
                self.addFirstRecording.alpha = 1.0
                
            }, completion: nil)
            
        } else {
            addFirstRecording.isHidden = true
            dataTableView.isHidden = false
        }
        
    }
    
    @objc func didTapFirstRecordingButton() {
        performSegue(withIdentifier: "RecorderView", sender: nil)
    }
    
    func presentAlertFor(row: Int) {
        let alertController = UIAlertController(title: "Edit Title", message: "Change recording title", preferredStyle: .alert)
        let currentRecording = CoreDataService.shared.recordedData[row]
        alertController.addTextField { textField in
            textField.text = currentRecording.title
        }
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            
            if let textfield = alertController.textFields?.first {
                
                currentRecording.title = textfield.text
                CoreDataService.shared.currentCoreData(state: .save)
                
                // Reload Table View
                self.dataTableView.reloadData()
            }
            
        }
        
        alertController.addAction(doneAction)
        present(alertController, animated: true, completion: nil)
    }
        
}

extension MainViewController: UpdateRecordingsDelegate {
    func updateRecordingsTableView() {
        CoreDataService.shared.currentCoreData(state: .load)
        dataTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecorderView" {
            let destination = segue.destination as! RecorderViewController
            destination.delegate = self
        }
    }
}
