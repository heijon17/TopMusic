//
//  Utils.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 30/10/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import Foundation

class Utils {
    
    static func convertSeconds(milliseconds: String) -> String {
        var result = ""
        let intMs = Int(milliseconds)
        if let ms = intMs {
            let seconds = ms / 1000
            let minutes = seconds / 60
            result = "\(minutes):"
            result += (seconds % 60) >= 10 ? "\(seconds % 60)" : "0\(seconds % 60)"
        }
        return result
    }
    
}
