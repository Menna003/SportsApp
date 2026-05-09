//
//  LeaguesDetailsPresenter.swift
//  SportsApp
//
//  Created by Manona on 05/05/2026.
//

import Foundation

protocol LeaguesDetailsViewProtocol: AnyObject {
    func reloadAll()
    func showError()
}

class LeaguesDetailsPresenter {

    weak var view: LeaguesDetailsViewProtocol?
    var network = NetworkService.shared

    private var sport: String = ""
    private var leagueId: Int = 0

    private(set) var upcomingEvents: [Event] = []
    private(set) var latestEvents: [Event] = []
    private(set) var teams: [Team] = []

    func setContext(sport: String, leagueId: Int) {
        self.sport = sport
        self.leagueId = leagueId
    }

    func loadAllData() {
        let group = DispatchGroup()

        group.enter()
        network.fetchUpcomingEvents(sport: sport, leagueId: leagueId) { [weak self] response in
            if let events = response?.result {
                self?.upcomingEvents = events
            }
            group.leave()
        }

        group.enter()
        network.fetchLatestEvents(sport: sport, leagueId: leagueId) { [weak self] response in
            if let events = response?.result {
                self?.latestEvents = events
            }
            group.leave()
        }

        group.enter()
        network.fetchTeams(sport: sport, leagueId: leagueId) { [weak self] response in
            if let teams = response?.result {
                self?.teams = teams
            }
            group.leave()
        }

        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            if self.upcomingEvents.isEmpty && self.latestEvents.isEmpty && self.teams.isEmpty {
                self.view?.showError()
            } else {
                self.view?.reloadAll()
            }
        }
    }
}
