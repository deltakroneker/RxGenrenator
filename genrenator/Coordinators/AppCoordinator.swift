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
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 35.0)!]
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
        guard let mainVC = self.navigationController.viewControllers.first as? MainViewController,
            let mainVM = mainVC.viewModel else { return }
        
        let vc = ListViewController.instantiate(from: .main)
        vc.coordinator = self
        vc.viewModel = ListViewModel(allGenres: mainVM.allGenres)
        vc.title = "All genres"
        navigationController.pushViewController(vc, animated: true)
    }
}
