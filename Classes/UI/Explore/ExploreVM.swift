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
    private var sectionItems: [MagazineLayoutSection] = []

    let steps = PublishRelay<Step>()
    private let bag = DisposeBag()
    private var isLoading = false
    private var repository: SectionRepository = SectionRepositoryImpl()

    init() {
        if isLoading { return }
        isLoading = true
        repository.getAllSections()
          .subscribe(onNext: { (result) in
              guard result.succeeded, let section = result.data else { return }
              self.onLoadComplete(section: section)
          }, onError: { (error) in
              self.onError(message: error.localizedDescription)
            }).disposed(by: bag)
    }

    func onLoadComplete(section: Section) {
        self.isLoading = false
        self.sectionItems = ExploreBuilder().build(section: section)
        self.$sections.accept(self.sectionItems)
    }

    func onError(message: String) {
        self.isLoading = false
        print(message)
    }
}
