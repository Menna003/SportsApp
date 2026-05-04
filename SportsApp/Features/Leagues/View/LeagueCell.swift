//
//  LeagueCell.swift
//  SportsApp
//
//  Created by Manona on 02/05/2026.
//

import UIKit
import SDWebImage

class LeagueCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    var onFavTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 32
        contentView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
        leagueImage.layer.cornerRadius = leagueImage.frame.height / 2
        leagueImage.clipsToBounds = true
    }
    
    @IBAction func favBtn(_ sender: Any) {
        onFavTapped?()
    }
    
    func configure(with league: League, isFavorite: Bool) {
        
        leagueNameLabel.text = league.leagueName ?? "No Name"
        
        updateFavUI(isFavorite: isFavorite)
        
        if let urlString = league.leagueLogo,
           let url = URL(string: urlString) {
            
            leagueImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder-league"))
        } else {
            leagueImage.image = UIImage(named: "placeholder-league")
        }
    }

    func updateFavUI(isFavorite: Bool) {
        let imageName = isFavorite ? "fav-icon" : "fav-icon-outline"
        favButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
