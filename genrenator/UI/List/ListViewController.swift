//
//  ListViewController.swift
//  genrenator
//
//  Created by Nikola Milic on 3/26/19.
//  Copyright © 2019 Nikola Milic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct Genre {
    let name: String
}

class ListViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    
    weak var coordinator: AppCoordinator?
    var viewModel: ListViewModel!
    let bag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Genre>>(configureCell: { (dataSource, table, indexPath, genre) -> UITableViewCell in
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = genre.name
        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.allGenres
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
}
