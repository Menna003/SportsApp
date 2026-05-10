//
//  MockNetworkService.swift
//  SportsApp
//
//  Created by Manona on 09/05/2026.
//


import Foundation
@testable import SportsApp

final class MockNetworkService: NetworkServiceProtocol {

    var shouldReturnNil = false

    func fetchLeagues(
        for sport: String,
        completion: @escaping (LeaguesResponse?) -> Void
    ) {

        if shouldReturnNil {
            completion(nil)
            return
        }

        let league = League(
            leagueKey: 1,
            leagueName: "Premier League",
            countryKey: 10,
            countryName: "England",
            leagueLogo: "",
            countryLogo: "",
            leagueYear: "2026",
            leagueSurface: "Grass"
        )

        let response = LeaguesResponse(
            success: 1,
            result: [league]
        )

        completion(response)
    }

    func fetchUpcomingEvents(
        sport: String,
        leagueId: Int,
        completion: @escaping (EventsResponse?) -> Void
    ) {

        if shouldReturnNil {
            completion(nil)
            return
        }

        let event = Event(
            eventKey: 1,
            eventDate: "2026-05-10",
            eventTime: "20:00",
            homeTeam: "Liverpool",
            awayTeam: "Arsenal",
            finalResult: "2-1",
            homeLogo: "",
            awayLogo: ""
        )

        let response = EventsResponse(
            success: 1,
            result: [event]
        )

        completion(response)
    }

    func fetchLatestEvents(
        sport: String,
        leagueId: Int,
        completion: @escaping (EventsResponse?) -> Void
    ) {

        if shouldReturnNil {
            completion(nil)
            return
        }

        let event = Event(
            eventKey: 2,
            eventDate: "2026-04-20",
            eventTime: "21:00",
            homeTeam: "Barcelona",
            awayTeam: "Real Madrid",
            finalResult: "3-2",
            homeLogo: "",
            awayLogo: ""
        )

        let response = EventsResponse(
            success: 1,
            result: [event]
        )

        completion(response)
    }

    func fetchTeams(
        sport: String,
        leagueId: Int,
        completion: @escaping (TeamsResponse?) -> Void
    ) {

        if shouldReturnNil {
            completion(nil)
            return
        }

        let team = Team(
            teamKey: 1,
            teamName: "Liverpool",
            teamLogo: "",
            players: []
        )

        let response = TeamsResponse(
            success: 1,
            result: [team]
        )

        completion(response)
    }

    func fetchTeamDetails(
        sport: String,
        teamId: Int,
        completion: @escaping (TeamDetailsResponse?) -> Void
    ) {

        if shouldReturnNil {
            completion(nil)
            return
        }

        let player = Player(
            playerKey: 10,
            playerName: "Mohamed Salah",
            playerNumber: "11",
            playerImage: "",
            playerType: "Forward",
            playerAge: "33",
            playerCountry: "Egypt"
        )

        let team = Team(
            teamKey: 1,
            teamName: "Liverpool",
            teamLogo: "",
            players: [player]
        )

        let response = TeamDetailsResponse(
            success: 1,
            result: [team]
        )

        completion(response)
    }
}
