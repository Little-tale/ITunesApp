//
//  Extention.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/6/24.
//

import UIKit


extension UIView  {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension Double {
    
    var rounded2: String {
        return NumberAssistance.shared.roundedNum(self, 2)
    }
    
}
