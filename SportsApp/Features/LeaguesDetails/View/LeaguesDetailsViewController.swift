//
//  LeaguesDetailsPresenter.swift
//  SportsApp
//
//  Created by Manona on 05/05/2026.
//

import UIKit

class LeaguesDetailsViewController: UIViewController,
                                    UICollectionViewDelegate,
                                    UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    let presenter = LeaguesDetailsPresenter()

    var sport: String?
    var leagueId: Int?
    var league: League?

    private let animator = CollectionViewAnimator()
    private var isFirstLoad = true

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = makeLayout()
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .clear

        collectionView.register(UINib(nibName: "HeaderCell",        bundle: nil), forCellWithReuseIdentifier: "HeaderCell")
        collectionView.register(UINib(nibName: "UpcomingCell",      bundle: nil), forCellWithReuseIdentifier: "UpcomingCell")
        collectionView.register(UINib(nibName: "LatestCell",        bundle: nil), forCellWithReuseIdentifier: "LatestCell")
        collectionView.register(UINib(nibName: "TeamsCell",         bundle: nil), forCellWithReuseIdentifier: "TeamsCell")
        collectionView.register(
            UINib(nibName: "SectionHeaderView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeaderView"
        )

        presenter.view = self

        if let sport = sport, let leagueId = leagueId {
            presenter.setContext(sport: sport, leagueId: leagueId)
            presenter.loadAllData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isFirstLoad = true
        animator.reset()
        tabBarController?.tabBar.isHidden = false
    }

    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0:  return self.headerSection()
            case 1:  return self.upcomingSection()
            case 2:  return self.latestSection()
            default: return self.teamsSection()
            }
        }
    }

    private func headerSection() -> NSCollectionLayoutSection {
        let item  = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(260)), subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }

    private func upcomingSection() -> NSCollectionLayoutSection {
        let item    = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group   = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(170), heightDimension: .absolute(150)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 8, leading: 16, bottom: 12, trailing: 16)
        section.boundarySupplementaryItems = [sectionHeader()]
        return section
    }

    private func latestSection() -> NSCollectionLayoutSection {
        let item    = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)))
        let group   = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 8, leading: 16, bottom: 12, trailing: 16)
        section.boundarySupplementaryItems = [sectionHeader()]
        return section
    }

    private func teamsSection() -> NSCollectionLayoutSection {
        let item    = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .absolute(100), heightDimension: .absolute(120)))
        let group   = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(100), heightDimension: .absolute(120)), subitems: [item])
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

    func numberOfSections(in collectionView: UICollectionView) -> Int { 4 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:  return 1
        case 1:  return presenter.upcomingEvents.count
        case 2:  return presenter.latestEvents.count
        default: return presenter.teams.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            if let league = league { cell.configure(with: league, teamsCount: presenter.teams.count) }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCell", for: indexPath) as! UpcomingCell
            cell.configure(with: presenter.upcomingEvents[indexPath.item])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestCell", for: indexPath) as! LatestCell
            cell.configure(with: presenter.latestEvents[indexPath.item])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCell", for: indexPath) as! TeamsCell
            cell.configure(with: presenter.teams[indexPath.item])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeaderView", for: indexPath) as! SectionHeaderView
        switch indexPath.section {
        case 1: header.titleLabel.text = "Upcoming Events"
        case 2: header.titleLabel.text = "Latest Events"
        case 3: header.titleLabel.text = "Teams"
        default: header.titleLabel.text = ""
        }
        return header
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isFirstLoad {
            animator.animateCell(cell, at: indexPath, section: indexPath.section)
        }
    }
}

extension LeaguesDetailsViewController: LeaguesDetailsViewProtocol {

    func reloadAll() {
        isFirstLoad = true
        animator.reset()
        collectionView.reloadData()
        isFirstLoad = false
    }

    func showError() {}
}
