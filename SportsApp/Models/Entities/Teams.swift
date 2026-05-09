//
//  TeamsResponse.swift
//  SportsApp
//
//  Created by Manona on 05/05/2026.
//


import Foundation

struct TeamsResponse: Decodable {
    let success: Int?
    let result: [Team]?
}

struct Team: Decodable {
    let teamKey:  Int?
    let teamName: String?
    let teamLogo: String?
    let players:  [Player]?

    enum CodingKeys: String, CodingKey {
        case teamKey  = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
    }
}

struct TeamDetailsResponse: Decodable {
    let success: Int?
    let result: [Team]?
}

struct Player: Decodable {
    let playerKey:     Int?
    let playerName:    String?
    let playerNumber:  String?
    let playerImage:   String?
    let playerType:    String?
    let playerAge:     String?
    let playerCountry: String?

    enum CodingKeys: String, CodingKey {
        case playerKey     = "player_key"
        case playerName    = "player_name"
        case playerNumber  = "player_number"
        case playerImage   = "player_image"
        case playerType    = "player_type"
        case playerAge     = "player_age"
        case playerCountry = "player_country"
    }
}
