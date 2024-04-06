//
//  IturesModel.swift
//  ITunesApp
//
//  Created by Jae hyung Kim on 4/5/24.
//

import Foundation

import Foundation

// MARK: - ITunes
struct ITunes: Decodable {
    let results: [SearchResult]
}

// MARK: - Result
struct SearchResult: Decodable {
    let bundleId: String // 프라이머리 키
    let artworkUrl60, artworkUrl100: String // 앱 로고
    let screenshotUrls: [String] // 스크린샷
    let minimumOSVersion: String // 최소 버전
    let averageUserRating: Double // 평점
    let trackCensoredName : String // 카카오톡 같이 이름 나옴 --> 검열 이름
    let sellerName: String // 회사 이름
    let releaseNotes: String? // 릴리즈 노트
    let artistID: Int // 362057950 같이 회사 ID 인가봄
    let artistName: String // 이것도 회사 이름이 나오긴 함
    let genres: [String] // 장르 인데 ["소셜 네트워킹", "생산성"] 같이 나옴
    let description: String // 앱 설명?
    let trackID: Int // 프라이머리 키
    let trackName: String // 앱이름 나옴 또
    let releaseDate, currentVersionReleaseDate: String // TMZ 데이트 형식으로 오긴하나 String으로 받아야함
    let averageUserRatingForCurrentVersion: Double // 이것도 평점임
    let trackContentRating: String // 연령 레이팅
    let version : String // 앱 버전
    let wrapperType: String // Ios Mac IPad 같은 타입 을 명시 하지만 출력은 Software 같이 옴

    enum CodingKeys: String, CodingKey {
        case bundleId
        case artworkUrl60, artworkUrl100, screenshotUrls
        case minimumOSVersion = "minimumOsVersion"
        case averageUserRating, trackCensoredName, sellerName, releaseNotes
        case artistID = "artistId"
        case artistName, genres, description
        case trackID = "trackId"
        case trackName, releaseDate, currentVersionReleaseDate, averageUserRatingForCurrentVersion, trackContentRating, version, wrapperType
    }
}
