//
//  CollectionViewAnimator.swift
//  SportsApp
//
//  Created by Manona on 05/05/2026.
//

import UIKit

class CollectionViewAnimator {

    private var animatedIndexPaths: Set<IndexPath> = []

    func animateCell(
        _ cell: UICollectionViewCell,
        at indexPath: IndexPath,
        section: Int
    ) {

        guard !animatedIndexPaths.contains(indexPath) else { return }

        animatedIndexPaths.insert(indexPath)

        switch section {
        case 0:
            animateHeader(cell)
        case 1:
            animateUpcoming(cell, index: indexPath.item)
        case 2:
            animateLatest(cell)
        case 3:
            animateTeams(cell, index: indexPath.item)
        default:
            animateDefault(cell)
        }
    }
    
    private func animateHeader(_ cell: UICollectionViewCell) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.1,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
            animations: {
                cell.alpha = 1
                cell.transform = .identity
            }
        )
    }
    
    private func animateUpcoming(_ cell: UICollectionViewCell, index: Int) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(rotationAngle: -0.05).scaledBy(x: 0.9, y: 0.9)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.03 * Double(index),
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.8,
            options: .curveEaseOut,
            animations: {
                cell.alpha = 1
                cell.transform = .identity
            }
        )
    }
    
    private func animateLatest(_ cell: UICollectionViewCell) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        
        UIView.animate(
            withDuration: 0.6,
            delay: 0.05,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
            animations: {
                cell.alpha = 1
                cell.transform = .identity
            }
        )
    }
    
    private func animateTeams(_ cell: UICollectionViewCell, index: Int) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0.02 * Double(index),
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 1.0,
            options: .curveEaseOut,
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
            withDuration: 0.4,
            delay: 0.05,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
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
