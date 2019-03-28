//
//  MainViewController.swift
//  genrenator
//
//  Created by Nikola Milic on 3/4/19.
//  Copyright © 2019 Nikola Milic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController, Storyboarded {

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var newButton: UIButton!
    
    weak var coordinator: AppCoordinator?
    var viewModel: MainViewModel!
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "All genres", style: .plain, target: self, action: #selector(allTapped))
    }
    
    func setupBindings() {
        let input = MainViewModel.Input(newButtonPressed: newButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.randomGenreText
            .drive(genreLabel.rx.text)
            .disposed(by: bag)
    }
    
    @objc func allTapped() {
        coordinator?.showListOfGenres()
    }
}
