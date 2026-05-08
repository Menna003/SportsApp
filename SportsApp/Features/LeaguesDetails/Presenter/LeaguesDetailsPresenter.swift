//
//  LeaguesDetailsPresenter.swift
//  SportsApp
//
//  Created by Manona on 05/05/2026.
//

import Foundation

protocol LeaguesDetailsViewProtocol: AnyObject {
    func showUpcoming(_ events: [Event])
    func showLatest(_ events: [Event])
    func showTeams(_ teams: [Team])
    func showError()
}

class LeaguesDetailsPresenter {
    
    weak var view: LeaguesDetailsViewProtocol?
    var network = NetworkService.shared
    
    private var sport: String = ""
    private var leagueId: Int = 0
    
    func setContext(sport: String, leagueId: Int) {
        self.sport = sport
        self.leagueId = leagueId
    }
    
    func loadAllData() {
        
        fetchUpcoming()
        fetchLatest()
        fetchTeams()
    }
    
    private func fetchUpcoming() {
        
        network.fetchUpcomingEvents(sport: sport, leagueId: leagueId) { [weak self] response in
            
            guard let self = self else { return }
            
            if let events = response?.result {
                self.view?.showUpcoming(events)
            } else {
                self.view?.showError()
            }
        }
    }
    
    private func fetchLatest() {
        
        network.fetchLatestEvents(sport: sport, leagueId: leagueId) { [weak self] response in
            
            guard let self = self else { return }
            
            if let events = response?.result {
                self.view?.showLatest(events)
            } else {
                self.view?.showError()
            }
        }
    }
    
    private func fetchTeams() {
        
        network.fetchTeams(sport: sport, leagueId: leagueId) { [weak self] response in
            
            guard let self = self else { return }
            
            if let teams = response?.result {
                self.view?.showTeams(teams)
            } else {
                self.view?.showError()
            }
        }
    }
}
