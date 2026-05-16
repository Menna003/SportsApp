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
    }
}
