//
//  ExploreDataSource.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

final class ExploreDataSource {
    private let bag = DisposeBag()
    private var repository: SectionRepository = SectionRepositoryImpl()
    public var sectionItems: [MagazineLayoutSection] = []

    init() {
        let group = DispatchGroup()
        group.enter()
        self.repository.getAllSections()
         .subscribe(onNext: { (result) in
             guard result.succeeded, let data = result.data else { return }
             self.sectionItems = ExploreBuilder.shared.build(section: data)
             group.leave()
         }, onError: { (error) in
        }).disposed(by: self.bag)
        group.wait()
    }
}
