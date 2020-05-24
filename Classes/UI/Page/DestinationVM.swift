//
//  DestinationVM.swift
//  DesignSystemExample
//
//  Created by Igors Nemenonoks on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

final class DestinationVM: SectionedViewModel {

    @VMProperty([]) var sections: Observable<[MagazineLayoutSection]>
    private var sectionItems: [MagazineLayoutSection] = []

    let steps = PublishRelay<Step>()
    private let bag = DisposeBag()

    private var repository: SectionRepository = SectionRepositoryImpl()
    private var isLoading = false

    init() {
        if isLoading {
          return
        }

        isLoading = true
        repository.getAllSections()
          .subscribe(onNext: { (result) in
              switch result.succeeded {
              case true:
                self.isLoading = false
                guard let section = result.data else { return }
                self.onLoadComplete(section: section)
                break
              default:
                self.onError(message: Exception.InvalidIntegrationException(message: result.message!).errorDescription!)
                break
              }

          }, onError: { (error) in
              self.isLoading = false
              self.onError(message: error.localizedDescription)
        })
    }

    func onLoadComplete(section: Section) {
        sectionItems = self.prepareSections(section: section)
        $sections.accept(sectionItems)
    }

    func onError(message: String) {

    }

    private func prepareSections(section: Section) -> [MagazineLayoutSection] {
        let rowTitle = RowDestinationTitleVM(title: section.title)
        let rowTextVms: [CellConfigurator] = section.rowItems.map { (row)  in
            return RowTextVM(text: row.headline).configurator()
        }

        let cardPhotoVMs: [CardPhotoThumbnailVM] = section.columnItems.map { (item)  in
            return CardPhotoThumbnailVM(url: item.imageUrl)
        }

        let rowHorizontalCardsCollectionVM: [CellConfigurator] = [
            RowHorizontalCardsCollectionVM(items: cardPhotoVMs, itemWidth: 100, itemHeight: 100, itemsSpacing: 10).configurator()
        ]

        let headerLayout = MagazineLayoutSection(items: [
            rowTitle.configurator()
        ], sectionInset: UIEdgeInsets(top: 0, left: 32, bottom: 16, right: 16))
        sectionItems.append(headerLayout)

        let rowLayout = MagazineLayoutSection(items: rowTextVms,
                                              header: .init(item: HeaderHeadline2VM(title: section.title).configurator(),
                                              visibilityMode: .visible(heightMode: HeaderHeadline2VM(title: section.title).heightMode, pinToVisibleBounds: false)),
        sectionInset: UIEdgeInsets(top: 0, left: 32, bottom: 16, right: 16))
        sectionItems.append(rowLayout)

        let contentLayout = MagazineLayoutSection(items: rowHorizontalCardsCollectionVM,
                                              header: .init(item: HeaderHeadline2VM(title: section.title).configurator(),
                                              visibilityMode: .visible(heightMode: HeaderHeadline2VM(title: section.title).heightMode, pinToVisibleBounds: false)))
        sectionItems.append(contentLayout)
        return sectionItems
    }
}

