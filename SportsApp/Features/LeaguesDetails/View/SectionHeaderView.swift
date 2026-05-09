//
//  SectionHeaderView.swift
//  SportsApp
//
//  Created by Manona on 08/05/2026.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .clear

        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = UIColor(
            red: 0/255,
            green: 120/255,
            blue: 60/255,
            alpha: 1
        )
    }
}
