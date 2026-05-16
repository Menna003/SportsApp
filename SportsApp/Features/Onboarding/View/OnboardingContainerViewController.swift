//
//  OnboardingContainerViewController.swift
//  SportsApp
//
//  Created by Manona on 14/05/2026.
//

import UIKit

class OnboardingContainerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!

    private var pageViewController: UIPageViewController!

    private var pages: [OnboardingContentViewController] = []

    private var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupButtons()
        setupPages()
        setupPageViewController()
    }

    private func setupButtons() {

        nextButton.layer.cornerRadius = 28
        nextButton.backgroundColor = UIColor.mainGreen
        nextButton.setTitleColor(.white, for: .normal)

        skipButton.setTitleColor(.white, for: .normal)
    }

    private func setupPages() {

        let first = createPage(
            image: "onboarding1",
            title: "Live The Match",
            description: "Follow leagues and matches instantly."
        )

        let second = createPage(
            image: "onboarding2",
            title: "Track Your Team",
            description: "Discover teams, players and statistics."
        )

        let third = createPage(
            image: "onboarding3",
            title: "Never Miss A Goal",
            description: "Get the latest events and scores anytime."
        )

        pages = [first, second, third]

        pageControl.numberOfPages = pages.count
    }

    private func createPage(
        image: String,
        title: String,
        description: String
    ) -> OnboardingContentViewController {

        let vc = OnboardingContentViewController(
            nibName: "OnboardingContentViewController",
            bundle: nil
        )

        vc.imageName = image
        vc.titleText = title
        vc.descriptionText = description

        return vc
    }

    private func setupPageViewController() {

        pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )

        addChild(pageViewController)

        pageViewController.view.frame = containerView.bounds
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(pageViewController.view)

        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])

        pageViewController.didMove(toParent: self)

        pageViewController.setViewControllers(
            [pages[0]],
            direction: .forward,
            animated: true
        )
    }
}
