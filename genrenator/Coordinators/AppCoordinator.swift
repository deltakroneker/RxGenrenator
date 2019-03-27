//
//  AppCoordinator.swift
//  genrenator
//
//  Created by Nikola Milic on 3/4/19.
//  Copyright © 2019 Nikola Milic. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController.instantiate(from: .main)
        vc.coordinator = self
        vc.viewModel = MainViewModel()
        vc.title = "Genrenator"
        navigationController.pushViewController(vc, animated: false)
    }
}

extension AppCoordinator {
    
    func showListOfGenres() {
        let vc = ListViewController.instantiate(from: .main)
        vc.coordinator = self
        vc.viewModel = ListViewModel()
        vc.title = "All genres"
        navigationController.pushViewController(vc, animated: true)
    }
}
