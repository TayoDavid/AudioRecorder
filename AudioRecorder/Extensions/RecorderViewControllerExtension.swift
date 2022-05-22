//
//  RecorderViewControllerExtension.swift
//  AudioRecorder
//
//  Created by Omotayo on 22/05/2022.
//

import UIKit

extension RecorderViewController {
    
    func shouldAddAnimatingView() {
        
        let frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
        let rippleView = UIView(frame: frame)
        rippleView.translatesAutoresizingMaskIntoConstraints = false
        rippleView.backgroundColor = recordButton.backgroundColor
        rippleView.layer.cornerRadius = frame.height / 2
        
        view.insertSubview(rippleView, at: 0)
        
        NSLayoutConstraint.activate([
            rippleView.centerXAnchor.constraint(equalTo: recordButton.centerXAnchor),
            rippleView.centerYAnchor.constraint(equalTo: recordButton.centerYAnchor),
            
            rippleView.widthAnchor.constraint(equalToConstant: frame.width),
            rippleView.heightAnchor.constraint(equalToConstant: frame.height),
        ])
        
        UIView.animate(withDuration: 3.5, delay: .zero, options: [.repeat, .curveEaseInOut], animations: {
            
            rippleView.transform = CGAffineTransform(scaleX: 25, y: 25)
            rippleView.alpha = .zero
            
        }, completion: nil)
    }
    
}
