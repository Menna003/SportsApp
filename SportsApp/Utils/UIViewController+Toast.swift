//
//  UIViewController+Toast.swift
//  SportsApp
//
//  Created by Manona on 09/05/2026.
//

import UIKit

extension UIViewController {

    func showToast(message: String) {

        let toastLabel = UILabel()

        toastLabel.backgroundColor = .white
        toastLabel.textColor = .black
        toastLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 0

        toastLabel.layer.cornerRadius = 14
        toastLabel.clipsToBounds = true

        toastLabel.layer.borderWidth = 1
        toastLabel.layer.borderColor = UIColor.black.withAlphaComponent(0.15).cgColor

        toastLabel.numberOfLines = 0

        let maxWidth = self.view.frame.width - 40

        let expectedSize = toastLabel.sizeThatFits(
            CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        )

        toastLabel.frame = CGRect(
            x: 20,
            y: self.view.frame.height - 120,
            width: maxWidth,
            height: expectedSize.height + 20
        )

        self.view.addSubview(toastLabel)

        UIView.animate(withDuration: 0.3) {
            toastLabel.alpha = 1
        } completion: { _ in

            UIView.animate(
                withDuration: 0.3,
                delay: 2,
                options: .curveEaseOut
            ) {
                toastLabel.alpha = 0
            } completion: { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
