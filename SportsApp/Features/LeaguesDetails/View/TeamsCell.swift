//
//  TeamsCell.swift
//  SportsApp
//
//  Created by Manona on 08/05/2026.
//

import UIKit
import SDWebImage

class TeamsCell: UICollectionViewCell {

    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        teamImage.layer.cornerRadius = teamImage.frame.height / 2
        teamImage.clipsToBounds = true
    }

    func configure(with team: Team) {

        teamLabel.text = team.teamName ?? "Team"

        if let logo = team.teamLogo,
           let url = URL(string: logo) {

            teamImage.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "placeholder-team")
            )

        } else {

            teamImage.image = UIImage(named: "placeholder-team")
        }
    }
}
