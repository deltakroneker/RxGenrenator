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

class MainViewController: UIViewController {

    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var newButton: UIButton!
    
    var viewModel: MainViewModel!
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        let input = MainViewModel.Input(newButtonPressed: newButton.rx.tap.asObservable())
        let output = viewModel.transform(input: input)
        
        output.randomGenreText
            .startWith("")
            .drive(genreLabel.rx.text)
            .disposed(by: bag)
    }

}

