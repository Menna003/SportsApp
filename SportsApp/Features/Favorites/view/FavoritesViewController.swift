//
//  FavoritesViewController.swift
//  SportsApp
//
//  Created by Manona on 29/04/2026.
//

import UIKit

class FavoritesViewController: UIViewController, FavoritesViewProtocol, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyImageView: UIImageView!

    let presenter = FavoritesPresenter()

    var favorites: [League] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        emptyImageView.isHidden = true

        tableView.register(
            UINib(nibName: "LeagueCell", bundle: nil),
            forCellReuseIdentifier: "LeagueCell"
        )

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

    func showFavorites(_ leagues: [League]) {

        favorites = leagues

        let isEmpty = leagues.isEmpty

        tableView.isHidden = isEmpty
        emptyImageView.isHidden = !isEmpty

        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "LeagueCell",
            for: indexPath
        ) as! LeagueCell
        let league = favorites[indexPath.row]
        let isFav = presenter.isFavorite(id: league.leagueKey ?? 0)
        cell.configure(with: league, isFavorite: isFav)
        cell.onFavTapped = { [weak self] in

            guard let self = self,
                  let id = league.leagueKey else { return }

            guard checkInternetOrShowToast() else { return }

            let alert = UIAlertController(
                title: "Remove Favorite",
                message: "Are you sure you want to remove this league from favorites?",
                preferredStyle: .alert
            )

            alert.addAction(
                UIAlertAction(
                    title: "Cancel",
                    style: .cancel
                )
            )

            alert.addAction(
                UIAlertAction(
                    title: "Remove",
                    style: .destructive
                ) { _ in
                    self.showToast(
                        message: "\(league.leagueName ?? "") removed from favorites"
                    )
                    self.presenter.deleteLeague(id: id)
                }
            )

            self.present(alert, animated: true)
        }

        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        guard checkInternetOrShowToast() else { return }

        let league = favorites[indexPath.row]

        let detailsVC = storyboard?.instantiateViewController(
            withIdentifier: "LeaguesDetailsViewController"
        ) as! LeaguesDetailsViewController

        detailsVC.league = league
        detailsVC.leagueId = league.leagueKey

        navigationController?.pushViewController(
            detailsVC,
            animated: true
        )
    }
}
