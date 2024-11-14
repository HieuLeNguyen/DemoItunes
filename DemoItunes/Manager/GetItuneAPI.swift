//
//  GetItuneAPI.swift
//  DemoItunes
//
//  Created by Nguyễn Văn Hiếu on 14/11/24.
//

import Foundation
import Alamofire
import SwiftyJSON

class ManagerAPI {
    static let shared = ManagerAPI()
    
    func getItunes(
        _ searchText: String,
        completion: @escaping (Result<[ItuneResult]?, Error>) -> Void
    ) {
        
        let url = String(format: "https://itunes.apple.com/search?term=%@&limit=20", searchText)
        
        AF.request(url, method: .get)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let ituneResult = ItuneModel(json: json)
                    completion(.success(ituneResult.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
