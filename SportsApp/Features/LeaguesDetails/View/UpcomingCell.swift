//
//  UpcomingCell.swift
//  SportsApp
//
//  Created by Manona on 08/05/2026.
//

import UIKit
import SDWebImage

class UpcomingCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayImage: UIImageView!
    @IBOutlet weak var homeImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true

        homeImage.layer.cornerRadius = homeImage.frame.height / 2
        homeImage.clipsToBounds = true

        awayImage.layer.cornerRadius = awayImage.frame.height / 2
        awayImage.clipsToBounds = true
    }

    func configure(with event: Event) {

        dateLabel.text = event.eventDate ?? "No Date"

        timeLabel.text = event.eventTime ?? "No Time"

        homeLabel.text = event.homeTeam ?? "Home Team"

        awayLabel.text = event.awayTeam ?? "Away Team"

        if let homeLogo = event.homeLogo,
           let url = URL(string: homeLogo) {

            homeImage.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "placeholder-home")
            )

        } else {

            homeImage.image = UIImage(named: "placeholder-home")
        }

        if let awayLogo = event.awayLogo,
           let url = URL(string: awayLogo) {

            awayImage.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "placeholder-away")
            )

        } else {

            awayImage.image = UIImage(named: "placeholder-away")
        }
    }
}
