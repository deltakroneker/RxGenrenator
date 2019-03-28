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
        let cell = table.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreCell
        cell.titleLabel.text = genre.name
        return cell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        setupBindings()
    }
    
    func setupBindings() {
        viewModel.allGenres
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
