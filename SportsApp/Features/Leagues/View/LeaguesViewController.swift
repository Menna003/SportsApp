//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by Manona on 02/05/2026.
//

import UIKit
import Lottie

class LeaguesViewController: UIViewController, LeaguesViewProtocol, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var sportName: String?
    let presenter = LeaguesPresenter()
    var leagues: [League] = []
    
    @IBOutlet weak var emptySearchImageView: UIImageView!
    @IBOutlet weak var leaguesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var lottieView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = sportName?.capitalized

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
        showLoading()
        if let sport = sportName {
            presenter.getLeagues(for: sport)
        }
        emptySearchImageView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.mainGreen,
            .font: UIFont.boldSystemFont(ofSize: 25)
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func showLoading() {
        let animation = LottieAnimationView(name: "loading")
        animation.loopMode = .loop
        animation.contentMode = .scaleAspectFit
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.play()
        
        view.addSubview(animation)
        NSLayoutConstraint.activate([
            animation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animation.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animation.widthAnchor.constraint(equalToConstant: 200),
            animation.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        lottieView = animation
        leaguesTableView.isHidden = true
        searchBar.isHidden = true
    }
    
    private func hideLoading() {
        lottieView?.stop()
        lottieView?.removeFromSuperview()
        lottieView = nil
        leaguesTableView.isHidden = false
        searchBar.isHidden = false
    }
    
    func showLeagues(_ leagues: [League]) {

        self.leagues = leagues
        DispatchQueue.main.async {
            self.hideLoading()
            let isSearching = !(self.searchBar.text ?? "").isEmpty
            let isEmpty = leagues.isEmpty
            self.emptySearchImageView.isHidden = !(isSearching && isEmpty)
            self.leaguesTableView.isHidden = isSearching && isEmpty
            self.leaguesTableView.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            self.hideLoading()
        }
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
            guard checkInternetOrShowToast() else {return}
        
            let wasFavorite = self.presenter.isFavorite(id: league.leagueKey)
            self.presenter.toggleFavorite(league: league)

            if wasFavorite {
                self.showToast(message: "\(league.leagueName ?? "") removed from favorites")
            } else {
                self.showToast(message: "\(league.leagueName ?? "") added to favorites")
            }
            self.leaguesTableView.reloadRows(at: [indexPath], with: .none)        }
        
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
