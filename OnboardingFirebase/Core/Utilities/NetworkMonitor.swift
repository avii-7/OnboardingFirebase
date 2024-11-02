//
//  NetworkMonitor.swift
//  OnboardingFirebase
//
//  Created by Arun on 02/11/24.
//

import SwiftUI
import Network

final class NetworkMonitor: ObservableObject {
    
    private let networkMonitor = NWPathMonitor()
    private let dispatchQueue = DispatchQueue(label: "networkMonitor")
    
    @State private(set) var isConnected = false
    
    init() {
        start()
    }
    
    private func start() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: dispatchQueue)
    }
}
