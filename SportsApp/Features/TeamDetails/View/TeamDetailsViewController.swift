//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Manona on 09/05/2026.
//

import UIKit
import SDWebImage
import Lottie

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var teamImage:    UIImageView!
    @IBOutlet weak var countryLogo:  UIImageView!
    @IBOutlet weak var countryName:  UILabel!
    @IBOutlet weak var countPlayers: UILabel!
    @IBOutlet weak var playersTable: UITableView!

    var sport:          String?
    var teamId:         Int?
    var teamName:       String?
    var teamLogoURL:    String?
    var countryLogoURL: String?
    var countryNameStr: String?

    private let presenter = TeamDetailsPresenter()
    private var lottieView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        presenter.view = self
        presenter.setContext(sport: sport ?? "football")
        showLoading()
        guard let teamId else { showErrorAlert(message: "Invalid team."); return }
        presenter.loadData(
            teamId:         teamId,
            teamName:       teamName,
            teamLogoURL:    teamLogoURL,
            countryLogoURL: countryLogoURL,
            countryName:    countryNameStr
        )
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        teamImage.layer.cornerRadius   = teamImage.frame.height / 2
        teamImage.clipsToBounds        = true
        countryLogo.layer.cornerRadius = countryLogo.frame.height / 2
        countryLogo.clipsToBounds      = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func setupNavigationBar() {
        title = teamName ?? "Team"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 22)
        ]
        navigationController?.navigationBar.standardAppearance   = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance    = appearance
    }

    private func setupTableView() {
        playersTable.delegate           = self
        playersTable.dataSource         = self
        playersTable.rowHeight          = UITableView.automaticDimension
        playersTable.estimatedRowHeight = 92
        playersTable.separatorStyle     = .none
        playersTable.backgroundColor    = .clear
        playersTable.register(
            UINib(nibName: "TeamDetailsCell", bundle: nil),
            forCellReuseIdentifier: "TeamDetailsCell"
        )
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
        playersTable.isHidden = true
    }

    private func hideLoading() {
        lottieView?.stop()
        lottieView?.removeFromSuperview()
        lottieView = nil
        playersTable.isHidden = false
    }

    private func showErrorAlert(message: String) {
        hideLoading()
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension TeamDetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.groupedPlayers().count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.groupedPlayers()[section].players.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.groupedPlayers()[section].type
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamDetailsCell", for: indexPath) as! TeamDetailsCell
        let player = presenter.groupedPlayers()[indexPath.section].players[indexPath.row]
        cell.configure(with: player)
        return cell
    }
}

extension TeamDetailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 92 }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font      = UIFont.boldSystemFont(ofSize: 15)
            header.textLabel?.textColor = UIColor.white
        }
    }
}

extension TeamDetailsViewController: TeamDetailsViewProtocol {

    func setTeamHeader(name: String?, teamLogoURL: String?, countryLogoURL: String?, countryNameText: String?) {
        if let urlStr = teamLogoURL, let url = URL(string: urlStr) {
            teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder-team"))
        } else {
            teamImage.image = UIImage(named: "placeholder-team")
        }

        if let urlStr = countryLogoURL, let url = URL(string: urlStr) {
            countryLogo.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder-country"))
        } else {
            countryLogo.image = UIImage(named: "placeholder-country")
        }

        countryName.text = countryNameText ?? "—"
    }

    func reloadTable() {
        let count = presenter.numberOfPlayers
        countPlayers.text = "\(count) \(count == 1 ? "Player" : "Players")"
        hideLoading()
        playersTable.reloadData()
    }

    func showError(message: String) {
        showErrorAlert(message: message)
    }
}
