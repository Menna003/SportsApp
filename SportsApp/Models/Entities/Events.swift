//
//  EventsResponse.swift
//  SportsApp
//
//  Created by Manona on 05/05/2026.
//


struct EventsResponse: Decodable {
    let success: Int?
    let result: [Event]?
}

struct Event: Decodable {
    let eventKey: Int?
    let eventDate: String?
    let eventTime: String?
    let homeTeam: String?
    let awayTeam: String?
    let homeScore: String?
    let awayScore: String?
    let homeLogo: String?
    let awayLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case homeTeam = "event_home_team"
        case awayTeam = "event_away_team"
        case homeScore = "event_home_final_result"
        case awayScore = "event_away_final_result"
        case homeLogo = "home_team_logo"
        case awayLogo = "away_team_logo"
    }
}