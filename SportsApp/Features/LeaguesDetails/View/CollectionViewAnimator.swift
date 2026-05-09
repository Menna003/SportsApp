//
//  CollectionViewAnimator.swift
//  SportsApp
//
//  Created by Manona on 05/05/2026.
//

import UIKit

class CollectionViewAnimator {

    private var animatedIndexPaths: Set<IndexPath> = []

    func animateCell(_ cell: UICollectionViewCell, at indexPath: IndexPath, section: Int) {
        guard !animatedIndexPaths.contains(indexPath) else { return }
        animatedIndexPaths.insert(indexPath)

        switch section {
        case 0:  animateHeader(cell)
        case 1:  animateUpcoming(cell, index: indexPath.item)
        case 2:  animateLatest(cell, index: indexPath.item)
        case 3:  animateTeams(cell, index: indexPath.item)
        default: animateDefault(cell)
        }
    }

    private func animateHeader(_ cell: UICollectionViewCell) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: -30)

        UIView.animate(
            withDuration: 0.6,
            delay: 0.05,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 0.4,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: {
                cell.alpha = 1
                cell.transform = .identity
            }
        )
    }

    private func animateUpcoming(_ cell: UICollectionViewCell, index: Int) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: 40)

        UIView.animate(
            withDuration: 0.55,
            delay: 0,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 0.5,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: {
                cell.alpha = 1
                cell.transform = .identity
            }
        )
    }

    private func animateLatest(_ cell: UICollectionViewCell, index: Int) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width * 0.4, y: 0)

        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.4,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: {
                cell.alpha = 1
                cell.transform = .identity
            }
        )
    }

    private func animateTeams(_ cell: UICollectionViewCell, index: Int) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: 30)

        UIView.animate(
            withDuration: 0.45,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: {
                cell.alpha = 1
                cell.transform = .identity
            }
        )
    }

    private func animateDefault(_ cell: UICollectionViewCell) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: 0, y: 30)

        UIView.animate(
            withDuration: 0.45,
            delay: 0,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 0.5,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: {
                cell.alpha = 1
                cell.transform = .identity
            }
        )
    }

    func reset() {
        animatedIndexPaths.removeAll()
    }
}
