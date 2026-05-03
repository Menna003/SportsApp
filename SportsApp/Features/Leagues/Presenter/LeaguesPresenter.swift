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
    private var favoriteIDs: Set<Int> = []
    
    func getLeagues(for sport: String) {
        
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
        return favoriteIDs.contains(id ?? -1)
    }
    
    func toggleFavorite(id: Int?) {
        let key = id ?? -1
        if favoriteIDs.contains(key) {
            favoriteIDs.remove(key)
        } else {
            favoriteIDs.insert(key)
        }
    }
}
