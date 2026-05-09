//
//  LeaguesDetailsViewController.swift
//  SportsApp
//
//  Created by Manona on 05/05/2026.
//

import UIKit
import Lottie

class LeaguesDetailsViewController: UIViewController,
                                    UICollectionViewDelegate,
                                    UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    let presenter = LeaguesDetailsPresenter()

    var sport: String?
    var leagueId: Int?
    var league: League?

    private let animator = CollectionViewAnimator()
    private var lottieView: LottieAnimationView?

    private enum Section: Int, CaseIterable {
        case header = 0, upcoming, latest, teams
    }

    private var visibleSections: [Section] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.mainGreen,
            .font: UIFont.boldSystemFont(ofSize: 25)
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance

        setupBlurOnBackground()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = makeLayout()
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .clear

        collectionView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCell")
        collectionView.register(UINib(nibName: "UpcomingCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingCell")
        collectionView.register(LatestSectionCell.self, forCellWithReuseIdentifier: "LatestSectionCell")
        collectionView.register(UINib(nibName: "TeamsCell", bundle: nil), forCellWithReuseIdentifier: "TeamsCell")
        collectionView.register(
            UINib(nibName: "SectionHeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeaderView"
        )

        presenter.view = self

        showLoading()

        if let sport = sport, let leagueId = leagueId {
            presenter.setContext(sport: sport, leagueId: leagueId)
            presenter.loadAllData()
        }
    }

    private func setupBlurOnBackground() {
        guard let backgroundImageView = view.subviews.first(where: { $0 is UIImageView }) as? UIImageView else { return }

        let blur = UIBlurEffect(style: .systemMaterialDark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.alpha = 0.75
        blurView.translatesAutoresizingMaskIntoConstraints = false

        backgroundImageView.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor)
        ])
    }

    private func showLoading() {
        let animation = LottieAnimationView(name: "loading")
        animation.loopMode = .loop
        animation.contentMode = .scaleAspectFit
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.play()

        view.addSubview(animation)
        NSLayoutConstraint.activate([
            animation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animation.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animation.widthAnchor.constraint(equalToConstant: 200),
            animation.heightAnchor.constraint(equalToConstant: 200)
        ])

        lottieView = animation
        collectionView.isHidden = true
    }

    private func hideLoading() {
        lottieView?.stop()
        lottieView?.removeFromSuperview()
        lottieView = nil
        collectionView.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animator.reset()
        tabBarController?.tabBar.isHidden = false
    }

    private func buildVisibleSections() {
        visibleSections = [.header]
        if !presenter.upcomingEvents.isEmpty { visibleSections.append(.upcoming) }
        if !presenter.latestEvents.isEmpty   { visibleSections.append(.latest)   }
        if !presenter.teams.isEmpty          { visibleSections.append(.teams)    }
    }

    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.visibleSections[sectionIndex]
            switch section {
            case .header:   return self.headerSection()
            case .upcoming: return self.upcomingSection()
            case .latest:   return self.latestSectionLayout()
            case .teams:    return self.teamsSection()
            }
        }
    }

    private func headerSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(143)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)
        return section
    }

    private func upcomingSection() -> NSCollectionLayoutSection {
        let cardWidth = UIScreen.main.bounds.width * 0.66
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(cardWidth), heightDimension: .absolute(190)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.interGroupSpacing = 12
        section.contentInsets = .init(top: 8, leading: 16, bottom: 12, trailing: 16)
        section.boundarySupplementaryItems = [sectionHeader()]
        return section
    }

    private func latestSectionLayout() -> NSCollectionLayoutSection {
        let itemCount = presenter.latestEvents.count
        let innerHeight = CGFloat(itemCount) * 130 + CGFloat(max(itemCount - 1, 0)) * 10
        let sectionHeight = min(innerHeight, 420)

        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(sectionHeight)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 8, leading: 16, bottom: 12, trailing: 16)
        section.boundarySupplementaryItems = [sectionHeader()]
        return section
    }

    private func teamsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(100), heightDimension: .absolute(120)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(100), heightDimension: .absolute(120)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 12
        section.contentInsets = .init(top: 8, leading: 16, bottom: 24, trailing: 16)
        section.boundarySupplementaryItems = [sectionHeader()]
        return section
    }

    private func sectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return visibleSections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch visibleSections[section] {
        case .header:   return 1
        case .upcoming: return presenter.upcomingEvents.count
        case .latest:   return 1
        case .teams:    return presenter.teams.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch visibleSections[indexPath.section] {
        case .header:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            if let league = league { cell.configure(with: league, teamsCount: presenter.teams.count) }
            return cell
        case .upcoming:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCell", for: indexPath) as! UpcomingCell
            cell.configure(with: presenter.upcomingEvents[indexPath.item])
            return cell
        case .latest:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestSectionCell", for: indexPath) as! LatestSectionCell
            cell.configure(with: presenter.latestEvents)
            return cell
        case .teams:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as! TeamsCell
            cell.configure(with: presenter.teams[indexPath.item])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
        switch visibleSections[indexPath.section] {
        case .upcoming: header.titleLabel.text = "Upcoming Events"
        case .latest:   header.titleLabel.text = "Latest Events"
        case .teams:    header.titleLabel.text = "Teams"
        default:        header.titleLabel.text = ""
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        animator.animateCell(cell, at: indexPath, section: indexPath.section)
    }
}

extension LeaguesDetailsViewController: LeaguesDetailsViewProtocol {

    func reloadAll() {
        DispatchQueue.main.async {
            self.buildVisibleSections()
            self.collectionView.collectionViewLayout = self.makeLayout()
            self.hideLoading()
            self.animator.reset()
            self.collectionView.reloadData()
        }
    }

    func showError() {
        DispatchQueue.main.async {
            self.hideLoading()
        }
    }
}
