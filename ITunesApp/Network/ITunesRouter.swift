//
//  ITunesRouter.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/5/24.
//

import Foundation
import Alamofire


enum ITunesRouter: URLRequestConvertible {
    
    case search(term: String)
    
    var baseUrl: URL {
        switch self {
        case .search:
            return URL(string: "https://itunes.apple.com/search?")!
        }
    }
    
    var path: String {
        switch self{
        case .search:
            "search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
           return .get
        }
    }
    
    var parametters: Parameters? {
        switch self {
        case .search(let search) :
            return [
                "term" : search,
                "country" : "KR",
                "entity" : "software"
            ]
        }
        
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(path).absoluteString.removingPercentEncoding!
        
        let request = try URLRequest.init(url: url, method: method)
        
        return try URLEncoding.default.encode(request, with: parametters)
    }
}
