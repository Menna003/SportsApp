//
//  HeaderCell.swift
//  SportsApp
//
//  Created by Manona on 08/05/2026.
//

import UIKit
import SDWebImage

class HeaderCell: UICollectionViewCell {

    @IBOutlet weak var leaguesTitle: UILabel!
    @IBOutlet weak var leaguesImage: UIImageView!
    @IBOutlet weak var countryLogo: UIImageView!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var countTeam: UILabel!
    @IBOutlet weak var countryTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false

        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true

        leaguesImage.layer.cornerRadius = 20
        leaguesImage.clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        countryLogo.layer.cornerRadius = countryLogo.frame.height / 2
        countryLogo.clipsToBounds = true
    }

    func configure(with league: League, teamsCount: Int) {

        leaguesTitle.text = league.leagueName ?? "League"
        countryTitle.text = league.countryName ?? "Unknown Country"
        seasonLabel.text = league.leagueYear ?? "2025"
        countTeam.text = "\(teamsCount)"

        if let leagueLogo = league.leagueLogo, let url = URL(string: leagueLogo) {
            leaguesImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder-country"))
        } else {
            leaguesImage.image = UIImage(named: "placeholder-country")
        }

        if let countryLogoURL = league.countryLogo, let url = URL(string: countryLogoURL) {
            countryLogo.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder-country"))
        } else {
            countryLogo.image = UIImage(named: "placeholder-country")
        }
    }
}
