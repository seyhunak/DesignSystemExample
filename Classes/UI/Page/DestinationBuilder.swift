//
//  DestinationBuilder.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow

final class DestinationBuilder {
    private var sectionItems: [MagazineLayoutSection] = []
    private let bag = DisposeBag()
    let steps = PublishRelay<Step>()
    private var section: Section?

    public func build(section: Section) -> [MagazineLayoutSection] {
        self.section = section
        sectionItems.append(headerLayoutVms)
        sectionItems.append(rowLayoutVms)
        sectionItems.append(contentLayoutVms)
        return sectionItems
    }
}

extension DestinationBuilder {
     private var headerVms: RowDestinationTitleVM {
         return RowDestinationTitleVM(title: self.section?.title ?? "")
     }

     private var headerLayoutVms: MagazineLayoutSection {
         return MagazineLayoutSection(items: [
             headerVms.configurator()
         ], sectionInset: UIEdgeInsets(top: 0, left: 32, bottom: 16, right: 16))
     }

     private var rowLayoutVms:  MagazineLayoutSection {
         return MagazineLayoutSection(items: rowTextVms,
                 header: .init(item: HeaderSubline(title: self.section?.title ?? "").configurator(),
                               visibilityMode: .visible(heightMode: HeaderSubline(title: self.section?.title ?? "").heightMode, pinToVisibleBounds: false)),
                 sectionInset: UIEdgeInsets(top: 0, left: 32, bottom: 16, right: 16))
     }

     private var contentLayoutVms: MagazineLayoutSection {
         return MagazineLayoutSection(items: rowHorizontalCardsCollectionVMs,
                                      header: .init(item: HeaderSubline(title: self.section?.title ?? "").configurator(),
                                                    visibilityMode: .visible(heightMode: HeaderSubline(title: self.section?.title ?? "").heightMode, pinToVisibleBounds: false)))
     }

     private var rowTextVms: [CellConfigurator] {
         return section?.rowItems.map { (row)  in
              return RowTextVM(text: row.headline).configurator()
         } ?? []
     }

     private var rowHorizontalCardsCollectionVMs: [CellConfigurator]{
         return [RowHorizontalCardsCollectionVM(items: cardPhotoVMs, itemWidth: 100, itemHeight: 100, itemsSpacing: 10).configurator()]
     }

     private var cardPhotoVMs: [CardPhotoThumbnailVM]{
         self.section?.cardItems.map { (item)  in
            return CardPhotoThumbnailVM(url: item.url)
         } ?? []
     }
}
