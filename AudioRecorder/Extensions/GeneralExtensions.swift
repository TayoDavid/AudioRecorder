//
//  GeneralExtensions.swift
//  AudioRecorder
//
//  Created by Omotayo on 22/05/2022.
//

import UIKit

extension Date {
    
    func formatedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
}
