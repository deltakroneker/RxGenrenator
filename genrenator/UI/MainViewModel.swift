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

class MainViewModel: ViewModelType {
    
    struct Input {
        let newButtonPressed: Observable<Void>
    }
    
    struct Output {
        let randomGenreText: Driver<String>
    }
    
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
            .asDriver(onErrorRecover: { _ in fatalError() })
        
        return Output(randomGenreText: randomGenreText)
    }
    
    init() {
    }

}
