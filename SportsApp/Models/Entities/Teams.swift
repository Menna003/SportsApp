//
//  TeamsResponse.swift
//  SportsApp
//
//  Created by Manona on 05/05/2026.
//


struct TeamsResponse: Decodable {
    let success: Int?
    let result: [Team]?
}

struct Team: Decodable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
    }
}