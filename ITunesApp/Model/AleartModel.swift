//
//  AleartModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/8/24.
//

import Foundation


enum AleartModel {
    case error
    
    
    var title: String {
        
        switch self {
        case .error:
            return "에러 발생!"
        }
    }
    
    var message: String {
        switch self {
        case .error:
            return "통신에 문제가 있습니다.\n잠시후 시도하여 주시기 바랍니다."
        }
    }
    
    var cancel: String {
        return "취소"
    }
}
