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
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var playerTitle: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var shirtImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

        playerImage.clipsToBounds = true
        playerImage.contentMode = .scaleAspectFill

        contentView.layer.cornerRadius = 14
        contentView.layer.masksToBounds = true

        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6

        backgroundColor = .clear
        contentView.backgroundColor = .white
        selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        )
        playerImage.layer.cornerRadius = playerImage.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with player: Player) {
        playerTitle.text = player.playerName.nonEmpty ?? "Unknown Player"
        playerType.text = player.playerType.nonEmpty ?? "—"
        playerNumber.text = player.playerNumber.nonEmpty ?? "#"

        if let urlStr = player.playerImage.nonEmpty,
           let url = URL(string: urlStr) {
            playerImage.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "placeholder-player")
            )
        } else {
            playerImage.image = UIImage(named: "placeholder-player")
        }
    }
}

private extension Optional where Wrapped == String {
    var nonEmpty: String? {
        guard let s = self,
              !s.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return nil
        }
        return s
    }
}
