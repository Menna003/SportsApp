//
//  LatestCell.swift
//  SportsApp
//
//  Created by Manona on 08/05/2026.
//

import UIKit
import SDWebImage

class LatestCell: UICollectionViewCell {

    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var awayImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius  = 20
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOpacity = 0.10
        layer.shadowOffset  = CGSize(width: 0, height: 3)
        layer.shadowRadius  = 6
        layer.masksToBounds = false

        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds      = true

        pinLabelsToBottom()
    }

    private func pinLabelsToBottom() {
        NSLayoutConstraint.deactivate(homeLabel.constraints)
        NSLayoutConstraint.deactivate(awayLabel.constraints)

        NSLayoutConstraint.activate([
            homeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            homeLabel.centerXAnchor.constraint(equalTo: homeImage.centerXAnchor),
            awayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            awayLabel.centerXAnchor.constraint(equalTo: awayImage.centerXAnchor),
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        homeImage.layer.cornerRadius = homeImage.frame.height / 2
        homeImage.clipsToBounds      = true
        awayImage.layer.cornerRadius = awayImage.frame.height / 2
        awayImage.clipsToBounds      = true
    }

    func configure(with event: Event) {
        homeLabel.text = event.homeTeam    ?? "Home Team"
        awayLabel.text = event.awayTeam   ?? "Away Team"
        score.text     = event.finalResult ?? "0 - 0"
        dateLabel.text = event.eventDate  ?? "No Date"
        timeLabel.text = event.eventTime  ?? "No Time"

        if let url = event.homeLogo.flatMap(URL.init) {
            homeImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder-home"))
        } else {
            homeImage.image = UIImage(named: "placeholder-home")
        }

        if let url = event.awayLogo.flatMap(URL.init) {
            awayImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder-away"))
        } else {
            awayImage.image = UIImage(named: "placeholder-away")
        }
    }
}
