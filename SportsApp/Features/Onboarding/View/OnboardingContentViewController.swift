//
//  OnboardingContentViewController.swift
//  SportsApp
//
//  Created by Manona on 14/05/2026.
//

import UIKit

class OnboardingContentViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var imageName: String?
    var titleText: String?
    var descriptionText: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImageView.image = UIImage(named: imageName ?? "")
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText

        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        backgroundImageView.alpha = 0
        titleLabel.alpha = 0
        descriptionLabel.alpha = 0

        UIView.animate(withDuration: 0.6) {
            self.backgroundImageView.alpha = 1
        }

        UIView.animate(withDuration: 0.6, delay: 0.2) {
            self.titleLabel.alpha = 1
        }

        UIView.animate(withDuration: 0.6, delay: 0.4) {
            self.descriptionLabel.alpha = 1
        }
    }
}
