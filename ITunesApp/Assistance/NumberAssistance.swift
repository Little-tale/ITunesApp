//
//  NumberAssistance.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import Foundation


class NumberAssistance {
    static let shared = NumberAssistance()
    let formatter =  NumberFormatter()
    private init() {}
    
    
    func roundedNum(_ double: Double, _ max: Int) -> String {
        formatter.maximumFractionDigits = max
        formatter.roundingMode = .ceiling
        let results = formatter.string(from: NSNumber(value: double)) ?? "0"
        
        return results
    }
    
}
