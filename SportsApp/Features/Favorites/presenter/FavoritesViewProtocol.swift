//
//  FavoritesViewProtocol.swift
//  SportsApp
//
//  Created by Manona on 04/05/2026.
//


import Foundation
import CoreData

protocol FavoritesViewProtocol: AnyObject {
    func showFavorites(_ leagues: [NSManagedObject])
}

class FavoritesPresenter {
    
    weak var view: FavoritesViewProtocol?
    
    func getFavorites() {
        let leagues = CoreDataManager.shared.fetchLeagues()
        view?.showFavorites(leagues)
    }
}