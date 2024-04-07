//
//  RealmModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/7/24.
//

import Foundation
import RealmSwift

class DownloadApp: Object {
    @Persisted(primaryKey: true) var appId: Int
    @Persisted var appName : String
    @Persisted var appImage: String
    @Persisted var regDate: Date
    
    
    convenience
    init(appId: Int, appName: String, appImage: String, regDate: Date) {
        self.init()
        self.appId = appId
        self.appName = appName
        self.appImage = appImage
        self.regDate = regDate
    }
}

