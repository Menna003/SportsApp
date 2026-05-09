//
//  TeamsCell.swift
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

    private let glassLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.withAlphaComponent(0.18).cgColor
        layer.borderColor = UIColor.white.withAlphaComponent(0.4).cgColor
        layer.borderWidth = 1
        return layer
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        layer.masksToBounds = false

        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.layer.insertSublayer(glassLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        glassLayer.frame = contentView.bounds
        glassLayer.cornerRadius = 20

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

        if let homeLogo = event.homeLogo, let url = URL(string: homeLogo) {
            homeImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder-home"))
        } else {
            homeImage.image = UIImage(named: "placeholder-home")
        }

        if let awayLogo = event.awayLogo, let url = URL(string: awayLogo) {
            awayImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder-away"))
        } else {
            awayImage.image = UIImage(named: "placeholder-away")
        }
    }
}
