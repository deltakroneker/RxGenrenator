//
//  MainViewModel.swift
//  genrenator
//
//  Created by Nikola Milic on 3/4/19.
//  Copyright © 2019 Nikola Milic. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class MainViewModel: ViewModelType {
    
    struct Input {
        let newButtonPressed: Observable<Void>
    }
    
    struct Output {
        let randomGenreText: Driver<String>
    }
    
    var allGenres: Observable<[SectionModel<String, Genre>]> {
        return allGenresSubject.asObservable()
    }
    
    private let allGenresSubject = ReplaySubject<[SectionModel<String, Genre>]>.create(bufferSize: 5)
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let randomGenreText = input.newButtonPressed
            .map { URL(string: "https://binaryjazz.us/wp-json/genrenator/v1/genre/")! }
            .map { URLRequest(url: $0) }
            .flatMapLatest {
                URLSession.shared.rx.data(request: $0)
                    .catchErrorJustReturn("Server Error".data(using: .utf8)!)
            }
            .map { String(data: $0, encoding: .utf8) ?? "" }
            .map { String($0.dropFirst().dropLast()) }
        
        randomGenreText
            .map( { SectionModel<String, Genre>(model: "", items: [Genre(name: $0)]) } )
            .scan(into: [SectionModel<String, Genre>](), accumulator: { $0.append($1) })
            .bind(to: allGenresSubject)
            .disposed(by: disposeBag)
        
        let driver = randomGenreText
            .startWith("")
            .asDriver(onErrorRecover: { _ in fatalError() })
        
        return Output(randomGenreText: driver)
    }
    
    init() {
    }
}
