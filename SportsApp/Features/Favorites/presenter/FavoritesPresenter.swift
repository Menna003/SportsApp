//
//  FavoritesViewProtocol.swift
//  SportsApp
//
//  Created by Manona on 04/05/2026.
//


import Foundation
import CoreData

protocol FavoritesViewProtocol: AnyObject {
    func showFavorites(_ leagues: [League])
}

class FavoritesPresenter {

    weak var view: FavoritesViewProtocol?

    func getFavorites() {

        let favorites = CoreDataManager.shared.fetchLeagues()

        let leagues = favorites.map { fav in

            League(
                leagueKey: fav.value(forKey: "id") as? Int,
                leagueName: fav.value(forKey: "name") as? String,
                countryKey: nil,
                countryName: nil,
                leagueLogo: fav.value(forKey: "logo") as? String,
                countryLogo: nil,
                leagueYear: nil,
                leagueSurface: nil
            )
        }

        view?.showFavorites(leagues)
    }

    func deleteLeague(id: Int) {

        CoreDataManager.shared.deleteLeague(id: id)
        getFavorites()
    }

    func isFavorite(id: Int) -> Bool {
        CoreDataManager.shared.isFavorite(id: id)
    }
}
