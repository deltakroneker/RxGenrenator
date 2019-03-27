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
    
    func getData() -> Observable<[SectionModel<String, Genre>]> {
        return Observable.create { (observer) -> Disposable in
            
            let genres = [Genre(name: "Genre 1"),
                         Genre(name: "Genre 2"),
                         Genre(name: "Genre 3")]
            
            let section = [SectionModel(model: "", items: genres)]
            observer.onNext(section)
            observer.onCompleted()
            
            return Disposables.create {
                print("Disposed")
            }
        }
    }
}
