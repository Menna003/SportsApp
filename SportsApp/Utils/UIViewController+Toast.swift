//
//  UIViewController+Toast.swift
//  SportsApp
//
//  Created by Manona on 09/05/2026.
//

import UIKit

extension UIViewController {

    func showToast(message: String) {

        let container = UIView()
        container.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        container.layer.cornerRadius = 16
        container.clipsToBounds = true

        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center

        container.addSubview(label)
        view.addSubview(container)

        container.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            container.widthAnchor.constraint(lessThanOrEqualToConstant: 280),

            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
        ])

        container.alpha = 0
        container.transform = CGAffineTransform(translationX: 0, y: 20)

        UIView.animate(withDuration: 0.3) {
            container.alpha = 1
            container.transform = .identity
        }

        UIView.animate(
            withDuration: 0.3,
            delay: 2,
            options: .curveEaseOut
        ) {
            container.alpha = 0
            container.transform = CGAffineTransform(translationX: 0, y: 20)
        } completion: { _ in
            container.removeFromSuperview()
        }
    }
}
