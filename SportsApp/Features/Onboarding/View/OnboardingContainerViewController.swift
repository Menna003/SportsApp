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

    @IBAction func nextBtn(_ sender: Any) {
        if currentIndex < pages.count - 1 {
            currentIndex += 1
            pageViewController.setViewControllers(
                [pages[currentIndex]],
                direction: .forward,
                animated: true
            )

            pageControl.currentPage = currentIndex

            let title = currentIndex == pages.count - 1
            ? "Start"
            : "Next"

            nextButton.setTitle(title, for: .normal)

        } else {

            goToHome()
        }
    }

    @IBAction func skipBtn(_ sender: Any) {

        goToHome()
    }

    private func goToHome() {

        let storyboard = UIStoryboard(
            name: "Main",
            bundle: nil
        )

        let vc = storyboard.instantiateViewController(
            withIdentifier: "TabBarController"
        )

        vc.modalPresentationStyle = .fullScreen

        present(vc, animated: true)
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
            description: "Follow your favorite leagues, track live scores instantly and stay connected with every exciting football moment happening around the world in real time."
        )

        let second = createPage(
            image: "onboarding2",
            title: "Track Your Team",
            description: "Explore team details, discover player information and dive deeper into match statistics to know everything about your favorite club and its journey throughout the season."
        )

        let third = createPage(
            image: "onboarding3",
            title: "Never Miss A Goal",
            description: "Get upcoming fixtures, latest match results and important sports updates instantly wherever you are and enjoy a complete football experience anytime you want."
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

        pageViewController.dataSource = self
        pageViewController.delegate = self

        addChild(pageViewController)

        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(pageViewController.view)

        NSLayoutConstraint.activate([

            pageViewController.view.topAnchor.constraint(
                equalTo: containerView.topAnchor
            ),

            pageViewController.view.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor
            ),

            pageViewController.view.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),

            pageViewController.view.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            )
        ])

        pageViewController.didMove(toParent: self)

        pageViewController.setViewControllers(
            [pages[0]],
            direction: .forward,
            animated: true
        )
    }
}

extension OnboardingContainerViewController:
UIPageViewControllerDataSource,
UIPageViewControllerDelegate {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {

        guard let index = pages.firstIndex(
            of: viewController as! OnboardingContentViewController
        ) else { return nil }

        if index == 0 {
            return nil
        }

        return pages[index - 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {

        guard let index = pages.firstIndex(
            of: viewController as! OnboardingContentViewController
        ) else { return nil }

        if index == pages.count - 1 {
            return nil
        }

        return pages[index + 1]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {

        guard completed,
              let visibleVC = pageViewController.viewControllers?.first,
              let index = pages.firstIndex(
                of: visibleVC as! OnboardingContentViewController
              ) else { return }

        currentIndex = index

        pageControl.currentPage = index

        let title = index == pages.count - 1
        ? "Start"
        : "Next"

        nextButton.setTitle(title, for: .normal)
    }
}
