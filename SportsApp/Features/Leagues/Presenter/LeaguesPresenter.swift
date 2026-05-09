//
//  LeaguesPresenter.swift
//  SportsApp
//
//  Created by Manona on 02/05/2026.
//

//
//  LeaguesPresenter.swift
//  SportsApp
//
//  Created by Manona on 02/05/2026.
//

import Foundation

protocol LeaguesViewProtocol: AnyObject {
    func showLeagues(_ leagues: [League])
    func showError()
}

protocol NetworkServiceProtocol {
    func fetchLeagues(for sport: String, completion: @escaping (LeaguesResponse?) -> Void)
}

class LeaguesPresenter {
    
    weak var view: LeaguesViewProtocol?
    var network: NetworkServiceProtocol = NetworkService.shared
    
    private var leagues: [League] = []
    private var filteredLeagues: [League] = []
    
    var currentSport: String?
    
    func getLeagues(for sport: String) {
        
        currentSport = sport
        
        network.fetchLeagues(for: sport) { [weak self] response in
            
            guard let self = self else { return }
            
            if let leagues = response?.result {
                self.leagues = leagues
                self.filteredLeagues = leagues
                self.view?.showLeagues(leagues)
            } else {
                self.view?.showError()
            }
        }
    }
    
    func getDisplayedLeagues(isSearching: Bool) -> [League] {
        return isSearching ? filteredLeagues : leagues
    }
    
    func search(text: String) {
        
        let englishText = text.folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
            .filter { $0.isASCII }
        
        if englishText.isEmpty {
            filteredLeagues = leagues
        } else {
            filteredLeagues = leagues.filter {
                $0.leagueName?.lowercased().contains(englishText) ?? false
            }
        }
        
        view?.showLeagues(getDisplayedLeagues(isSearching: !englishText.isEmpty))
    }
    
    func isFavorite(id: Int?) -> Bool {
        guard let id = id else { return false }
        return CoreDataManager.shared.isFavorite(id: id)
    }

    func toggleFavorite(league: League) {
        
        guard let id = league.leagueKey else { return }
        
        if CoreDataManager.shared.isFavorite(id: id) {
            
            CoreDataManager.shared.deleteLeague(id: id)
            
        } else {
            
            CoreDataManager.shared.saveLeague(
                sport: currentSport ?? "",
                id: id,
                name: league.leagueName ?? "",
                logo: league.leagueLogo ?? ""
            )
        }
    }
}

