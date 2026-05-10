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

        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

        animateFavButton()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {

            self.onFavTapped?()
        }
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
        UIView.transition(with: favButton,
                          duration: 0.2,
                          options: .transitionCrossDissolve) {

            self.favButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    private func animateFavButton() {

        UIView.animate(
            withDuration: 0.45,
            delay: 0,
            usingSpringWithDamping: 0.25,
            initialSpringVelocity: 7,
            options: [.curveEaseInOut]
        ) {

            self.favButton.transform =
            CGAffineTransform(scaleX: 1.8, y: 1.8)
                .rotated(by: -.pi / 16)

        } completion: { _ in

            UIView.animate(withDuration: 0.15) {

                self.favButton.transform = .identity
            }
        }
    }
}


