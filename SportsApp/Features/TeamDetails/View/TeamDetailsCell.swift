//
//  TeamCell.swift
//  SportsApp
//
//  Created by Manona on 09/05/2026.
//

import UIKit

class TeamDetailsCell: UITableViewCell {

    @IBOutlet weak var playerNumber: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var playerTitle: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
