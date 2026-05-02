//
//  SportsCell.swift
//  SportsApp
//
//  Created by Manona on 01/05/2026.
//

import UIKit

class SportsCell: UICollectionViewCell {
    
    @IBOutlet weak var sportsImage: UIImageView!
    @IBOutlet weak var sportsLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderWidth = 1
        layer.borderColor = UIColor(hex: "#2E7D32").cgColor
        layer.cornerRadius = 32
        layer.masksToBounds = true
    }
}

