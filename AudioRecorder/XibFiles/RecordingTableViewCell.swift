//
//  RecordingTableViewCell.swift
//  AudioRecorder
//
//  Created by Omotayo on 22/05/2022.
//

import UIKit

class RecordingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    var playButtonClosure: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        
        playButton.shouldSetupSFSymbol(imageName: "chevron.right.circle", fontSize: 45)
        
    }
    
    @objc func didTapPlayButton() {
        playButtonClosure?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
