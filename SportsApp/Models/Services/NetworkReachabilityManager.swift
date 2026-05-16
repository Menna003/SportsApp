//
//  NetworkReachabilityManager.swift
//  SportsApp
//
//  Created by Manona on 09/05/2026.
//


import Foundation
import Reachability

final class NetworkReachabilityManager {

    static let shared = NetworkReachabilityManager()
    private let reachability: Reachability
    private(set) var isConnected: Bool = true
    var onStatusChange: ((Bool) -> Void)?
    private init() {
        reachability = try! Reachability()
        setup()
    }

    private func setup() {
        reachability.whenReachable = { [weak self] _ in
            self?.isConnected = true
            self?.onStatusChange?(true)
        }

        reachability.whenUnreachable = { [weak self] _ in
            self?.isConnected = false
            self?.onStatusChange?(false)
        }
        try? reachability.startNotifier()
    }
}
