//
//  LatestCell.swift
//  SportsApp
//
//  Created by Manona on 08/05/2026.
//

import UIKit

class LatestCell: UICollectionViewCell {

    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var teamScore: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var awayImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
