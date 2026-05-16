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

            let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")

            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            let vc: UIViewController

            if hasSeenOnboarding {
                vc = storyboard.instantiateViewController(withIdentifier: "TabBarController")
            } else {
                vc = storyboard.instantiateViewController(withIdentifier: "OnboardingContainerViewController")
            }

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}
