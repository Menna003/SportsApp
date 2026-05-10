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

        showToast(message: "Check your internet and try again later")
        return false
    }
}
