import Foundation

protocol NetworkServiceProtocol {

    func fetchLeagues(
        for sport: String,
        completion: @escaping (LeaguesResponse?) -> Void
    )

    func fetchUpcomingEvents(
        sport: String,
        leagueId: Int,
        completion: @escaping (EventsResponse?) -> Void
    )

    func fetchLatestEvents(
        sport: String,
        leagueId: Int,
        completion: @escaping (EventsResponse?) -> Void
    )

    func fetchTeams(
        sport: String,
        leagueId: Int,
        completion: @escaping (TeamsResponse?) -> Void
    )

    func fetchTeamDetails(
        sport: String,
        teamId: Int,
        completion: @escaping (TeamDetailsResponse?) -> Void
    )
}