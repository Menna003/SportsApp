//
//  SplashViewController.swift
//  SportsApp
//
//  Created by Manona on 10/05/2026.
//


import UIKit
import Lottie

class SplashViewController: UIViewController {

    private let animationView = LottieAnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupAnimation()
    }

    private func setupAnimation() {

        animationView.animation = LottieAnimation.named("splashAnimation")
        animationView.frame = CGRect(
            x: 0,
            y: 0,
            width: 250,
            height: 250
        )
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1.0

        view.addSubview(animationView)

        animationView.play { finished in

            let homeVC = UIStoryboard(
                name: "Main",
                bundle: nil
            ).instantiateViewController(
                withIdentifier: "TabBarController"
            )

            homeVC.modalPresentationStyle = .fullScreen

            self.present(homeVC, animated: true)
        }
    }
}
