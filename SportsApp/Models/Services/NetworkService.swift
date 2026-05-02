//
//  NetworkService.swift
//  SportsApp
//
//  Created by Manona on 02/05/2026.
//

import Foundation
import Alamofire

class NetworkService : NetworkServiceProtocol{
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchLeagues(for sport: String, completion: @escaping (LeaguesResponse?) -> Void) {
        
        let url = "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(API.key)"
        
        AF.request(url).responseData { response in
            
            switch response.result {
            case .success(let data):
                
                do {
                    let decoded = try JSONDecoder().decode(LeaguesResponse.self, from: data)
                    print("Leagues fetched")
                    completion(decoded)
                    
                } catch {
                    print("Decoding error: \(error)")
                    completion(nil)
                }
                
            case .failure(let error):
                print("Request error: \(error)")
                completion(nil)
            }
        }
    }
}
