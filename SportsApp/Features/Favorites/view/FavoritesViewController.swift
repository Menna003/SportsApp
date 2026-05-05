//
//  FavoritesViewController.swift
//  SportsApp
//
//  Created by Manona on 29/04/2026.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, FavoritesViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyImageView: UIImageView!
    let presenter = FavoritesPresenter()
    var favorites: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyImageView.isHidden = true
        
        tableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: "LeagueCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter.view = self
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.title = "Favorites"

        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.mainGreen,
            .font: UIFont.systemFont(ofSize: 25, weight: .bold)
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getFavorites()
    }
    
    func showFavorites(_ leagues: [NSManagedObject]) {
        self.favorites = leagues
        
        let isEmpty = leagues.isEmpty
        
        tableView.isHidden = isEmpty
        emptyImageView.isHidden = !isEmpty
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueCell
        
        let fav = favorites[indexPath.row]
        
        let id = fav.value(forKey: "id") as? Int
        let isFav = CoreDataManager.shared.isFavorite(id: id ?? 0)
        
        let league = League(
            leagueKey: id,
            leagueName: fav.value(forKey: "name") as? String,
            countryKey: nil,
            countryName: nil,
            leagueLogo: fav.value(forKey: "logo") as? String,
            countryLogo: nil,
            leagueYear: nil,
            leagueSurface: nil
        )
        
        cell.configure(with: league, isFavorite: isFav)
        
        cell.onFavTapped = { [weak self] in
            guard let self = self, let id = id else { return }
            
            CoreDataManager.shared.deleteLeague(id: id)
            self.presenter.getFavorites()
        }
        
        return cell
    }
}
