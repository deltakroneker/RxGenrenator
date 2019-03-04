//
//  AppCoordinator.swift
//  genrenator
//
//  Created by Nikola Milic on 3/4/19.
//  Copyright © 2019 Nikola Milic. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let viewController = storyboard.instantiateInitialViewController() as? MainViewController else { return }
        navigationController?.pushViewController(viewController, animated: false)
    }
}
