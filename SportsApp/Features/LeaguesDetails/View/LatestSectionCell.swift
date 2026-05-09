//
//  LatestSectionCell.swift
//  SportsApp
//
//  Created by Manona on 09/05/2026.
//


import UIKit

class LatestSectionCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    private var innerCollectionView: UICollectionView!
    private var events: [Event] = []
    private let animator = CollectionViewAnimator()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 130)
        layout.minimumLineSpacing = 10

        innerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        innerCollectionView.delegate = self
        innerCollectionView.dataSource = self
        innerCollectionView.backgroundColor = .clear
        innerCollectionView.isScrollEnabled = true
        innerCollectionView.showsVerticalScrollIndicator = true
        innerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        innerCollectionView.register(
            UINib(nibName: "LatestCell", bundle: nil),
            forCellWithReuseIdentifier: "LatestCell"
        )

        contentView.addSubview(innerCollectionView)
        NSLayoutConstraint.activate([
            innerCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            innerCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            innerCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            innerCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func configure(with events: [Event]) {
        self.events = events
        animator.reset()
        innerCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestCell", for: indexPath) as! LatestCell
        cell.configure(with: events[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        animator.animateCell(cell, at: indexPath, section: indexPath.section)
    }
}
