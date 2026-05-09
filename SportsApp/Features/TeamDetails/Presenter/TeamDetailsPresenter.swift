//
//  TeamDetailsPresenter.swift
//  SportsApp
//
//  Created by Manona on 09/05/2026.
//

import Foundation

protocol TeamDetailsViewProtocol: AnyObject {
    func reloadTable()
    func showError(message: String)
    func setTeamHeader(name: String?, teamLogoURL: String?, countryLogoURL: String?, countryNameText: String?)
}

class TeamDetailsPresenter {

    weak var view: TeamDetailsViewProtocol?
    var network = NetworkService.shared

    private var sport: String = ""
    private(set) var players: [Player] = []

    func setContext(sport: String) {
        self.sport = sport
    }

    func loadData(teamId: Int,
                  teamName: String?,
                  teamLogoURL: String?,
                  countryLogoURL: String?,
                  countryName: String?) {

        view?.setTeamHeader(
            name:            teamName,
            teamLogoURL:     teamLogoURL,
            countryLogoURL:  countryLogoURL,
            countryNameText: countryName
        )

        network.fetchTeamDetails(sport: sport, teamId: teamId) { [weak self] response in
            guard let self else { return }

            guard let team = response?.result?.first else {
                DispatchQueue.main.async { self.view?.showError(message: "Could not load players.") }
                return
            }

            self.players = team.players ?? []
            DispatchQueue.main.async { self.view?.reloadTable() }
        }
    }

    var numberOfPlayers: Int { players.count }

    func player(at index: Int) -> Player { players[index] }

    func groupedPlayers() -> [(type: String, players: [Player])] {
        var dict: [String: [Player]] = [:]
        let order = ["Goalkeepers", "Defenders", "Midfielders", "Forwards"]

        for player in players {
            let type = player.playerType ?? "Unknown"
            dict[type, default: []].append(player)
        }

        var result: [(String, [Player])] = []
        for key in order {
            if let group = dict[key] { result.append((key, group)); dict.removeValue(forKey: key) }
        }
        for key in dict.keys.sorted() {
            if let group = dict[key] { result.append((key, group)) }
        }
        return result
    }
}
