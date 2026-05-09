//
//  NetworkService.swift
//  SportsApp
//
//  Created by Manona on 02/05/2026.
//

import Foundation
import Alamofire

class NetworkService: NetworkServiceProtocol {

    static let shared = NetworkService()
    private init() {}

    func fetchLeagues(for sport: String, completion: @escaping (LeaguesResponse?) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(API.key)"
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do { completion(try JSONDecoder().decode(LeaguesResponse.self, from: data)) }
                catch { print("Leagues decode error: \(error)"); completion(nil) }
            case .failure(let error):
                print("Leagues request error: \(error)"); completion(nil)
            }
        }
    }

    func fetchUpcomingEvents(sport: String, leagueId: Int, completion: @escaping (EventsResponse?) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&leagueId=\(leagueId)&from=2026-05-01&to=2026-12-31&APIkey=\(API.key)"
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do { completion(try JSONDecoder().decode(EventsResponse.self, from: data)) }
                catch { print("Upcoming decode error: \(error)"); completion(nil) }
            case .failure(let error):
                print("Upcoming request error: \(error)"); completion(nil)
            }
        }
    }

    func fetchLatestEvents(sport: String, leagueId: Int, completion: @escaping (EventsResponse?) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&leagueId=\(leagueId)&from=2025-01-01&to=2026-05-01&APIkey=\(API.key)"
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do { completion(try JSONDecoder().decode(EventsResponse.self, from: data)) }
                catch { print("Latest decode error: \(error)"); completion(nil) }
            case .failure(let error):
                print("Latest request error: \(error)"); completion(nil)
            }
        }
    }

    func fetchTeams(sport: String, leagueId: Int, completion: @escaping (TeamsResponse?) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport)/?met=Teams&leagueId=\(leagueId)&APIkey=\(API.key)"
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do { completion(try JSONDecoder().decode(TeamsResponse.self, from: data)) }
                catch { print("Teams decode error: \(error)"); completion(nil) }
            case .failure(let error):
                print("Teams request error: \(error)"); completion(nil)
            }
        }
    }

    func fetchTeamDetails(sport: String, teamId: Int, completion: @escaping (TeamDetailsResponse?) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport)/?met=Teams&APIkey=\(API.key)&teamId=\(teamId)"
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do { completion(try JSONDecoder().decode(TeamDetailsResponse.self, from: data)) }
                catch { print("TeamDetails decode error: \(error)"); completion(nil) }
            case .failure(let error):
                print("TeamDetails request error: \(error)"); completion(nil)
            }
        }
    }
}
