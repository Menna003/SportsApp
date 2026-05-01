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

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r = CGFloat((int >> 16) & 0xFF) / 255
        let g = CGFloat((int >> 8) & 0xFF) / 255
        let b = CGFloat(int & 0xFF) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
