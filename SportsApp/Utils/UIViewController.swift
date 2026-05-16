//
//  UIViewController.swift
//  SportsApp
//
//  Created by Manona on 09/05/2026.
//

import UIKit

extension UIViewController {

    func checkInternetOrShowToast() -> Bool {

        if NetworkReachabilityManager.shared.isConnected {
            return true
        }

        let alert = UIAlertController(
            title: "No Internet Connection",
            message: "Please check your internet connection and try again.",
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        present(alert, animated: true)
        return false
    }
}
