//
//  UIButtonExtension.swift
//  AudioRecorder
//
//  Created by Omotayo on 22/05/2022.
//

import UIKit

extension UIButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func shouldSetupSFSymbol( imageName: String, fontSize: CGFloat ) {
        guard let image = UIImage(systemName: imageName) else { return }
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .ultraLight)
        
        setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        
        setImage(image, for: .normal)
    }
    
}

