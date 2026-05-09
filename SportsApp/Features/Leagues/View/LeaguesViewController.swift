//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Manona on 02/05/2026.
//

import UIKit

class LeaguesViewController: UIViewController, LeaguesViewProtocol, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var sportName: String?
    let presenter = LeaguesPresenter()
    var leagues: [League] = []
    
    @IBOutlet weak var leaguesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesTableView.register(UINib(nibName: "LeagueCell", bundle: nil), forCellReuseIdentifier: "LeagueCell")
        leaguesTableView.delegate = self
        leaguesTableView.dataSource = self
        
        searchBar.delegate = self
        
        let textField = searchBar.searchTextField
        textField.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.layer.borderWidth = 0
        searchBar.backgroundImage = UIImage()
        
        presenter.view = self
        
        if let sport = sportName {
            presenter.getLeagues(for: sport)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func showLeagues(_ leagues: [League]) {
        self.leagues = leagues
        
        DispatchQueue.main.async {
            self.leaguesTableView.reloadData()
        }
    }
    
    func showError() {
        print("Failed to load leagues")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueCell
        
        let league = leagues[indexPath.row]
        
        let isFav = presenter.isFavorite(id: league.leagueKey)
        
        cell.configure(with: league, isFavorite: isFav)
        
        cell.onFavTapped = { [weak self] in
            guard let self = self else { return }
            
            self.presenter.toggleFavorite(league: league)
            
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let detailsVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as! LeaguesDetailsViewController

            let selectedLeague = leagues[indexPath.row]

            detailsVC.sport = sportName
            detailsVC.leagueId = selectedLeague.leagueKey
            detailsVC.league = selectedLeague

            navigationController?.pushViewController(detailsVC, animated: true)
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.search(text: searchText)
    }
}
