//
//  TeamCell.swift
//  SportsApp
//
//  Created by Manona on 09/05/2026.
//

import UIKit
import SDWebImage

class TeamDetailsCell: UITableViewCell {

    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerType:   UILabel!
    @IBOutlet weak var playerTitle:  UILabel!
    @IBOutlet weak var playerImage:  UIImageView!
    @IBOutlet weak var shirtImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        playerImage.clipsToBounds  = true
        playerImage.contentMode    = .scaleAspectFill
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerImage.layer.cornerRadius = playerImage.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with player: Player) {
        playerTitle.text  = player.playerName.nonEmpty   ?? "Unknown Player"
        playerType.text   = player.playerType.nonEmpty   ?? "—"
        playerNumber.text = player.playerNumber.nonEmpty ?? "#"

        if let urlStr = player.playerImage.nonEmpty, let url = URL(string: urlStr) {
            playerImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder-team"))
        } else {
            playerImage.image = UIImage(named: "placeholder-team")
        }
    }
}

private extension Optional where Wrapped == String {
    var nonEmpty: String? {
        guard let s = self, !s.trimmingCharacters(in: .whitespaces).isEmpty else { return nil }
        return s
    }
}
