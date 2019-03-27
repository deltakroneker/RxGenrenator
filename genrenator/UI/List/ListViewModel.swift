//
//  ListViewModel.swift
//  genrenator
//
//  Created by Nikola Milic on 3/26/19.
//  Copyright © 2019 Nikola Milic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class ListViewModel {
    
    var allGenres: Observable<[SectionModel<String, Genre>]>
    
    init(allGenres: Observable<[SectionModel<String, Genre>]>) {
        self.allGenres = allGenres
    }
}
