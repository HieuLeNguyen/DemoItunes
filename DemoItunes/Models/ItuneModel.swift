//
//  ItuneModel.swift
//  DemoItunes
//
//  Created by Nguyễn Văn Hiếu on 14/11/24.
//

import Foundation
import SwiftyJSON

// MARK: - ItuneModel
class ItuneModel {
    let resultCount: Int?
    let results: [ItuneResult]?

    required public init(json: JSON) {
        resultCount = json["resultCount"].intValue
        results = json["results"].arrayValue.map { ItuneResult(json: $0)!}
    }
}

// MARK: - ItuneResult
class ItuneResult {
    let artistName: String?
    let trackCount: Int?
    let releaseDate: String?
    let primaryGenreName: String?
    let previewURL: String?
    let description, copyright, kind: String?
    let trackID: Int?
    let trackName: String?
    let trackViewURL: String?
    let artworkUrl30: String?
    let artworkUrl100: String?
    let trackPrice: Double?
    let currency: String?
    let collectionPrice: Double?
    let country: String?
    
    required public init?(json: JSON) {
        artistName = json["artistName"].stringValue
        trackCount = json["trackCount"].intValue
        releaseDate = json["releaseDate"].stringValue
        primaryGenreName = json["primaryGenreName"].stringValue
        previewURL = json["previewUrl"].stringValue
        description = json["description"].stringValue
        copyright = json["copyright"].stringValue
        kind = json["kind"].stringValue
        trackID = json["trackId"].intValue
        trackName = json["trackName"].stringValue
        trackViewURL = json["trackViewUrl"].stringValue
        artworkUrl30 = json["artworkUrl30"].stringValue
        artworkUrl100 = json["artworkUrl100"].stringValue
        trackPrice = json["trackPrice"].doubleValue
        currency = json["currency"].stringValue
        collectionPrice = json["collectionPrice"].doubleValue
        country = json["primaryGenreName"].stringValue
    }
}
