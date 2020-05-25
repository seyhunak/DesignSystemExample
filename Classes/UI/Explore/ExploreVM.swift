//
//  ExploreVM.swift
//  DesignSystemExample
//
//  Created by Igors Nemenonoks on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

final class ExploreVM: SectionedViewModel {
    @VMProperty([]) var sections: Observable<[MagazineLayoutSection]>

    let steps = PublishRelay<Step>()
    private let bag = DisposeBag()
    private var repository: SectionRepository = SectionRepositoryImpl()
    private var builder: ExploreBuilder = ExploreBuilder()

    init(sectionItems: [MagazineLayoutSection]) {
        $sections.accept(sectionItems)
        ExploreBuilder.shared.destinationsVms.forEach { $0.steps.bind(to: self.steps).disposed(by: bag) }
    }
}
