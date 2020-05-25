//
//  ExploreBuilder.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxFlow

final class ExploreBuilder {
    static let shared = ExploreBuilder()
    private let bag = DisposeBag()
    let steps = PublishRelay<Step>()

    private var sectionItems: [MagazineLayoutSection] = []
    public var section: Section?

    public func build(section: Section) -> [MagazineLayoutSection] {
        self.section = section
        sectionItems.append(headerLayoutVms)
        sectionItems.append(cardLayoutVms)
        sectionItems.append(rowLayoutVms)
        return sectionItems
    }
}

extension ExploreBuilder {
    private var headerVms: HeaderSectionTitleVM {
        return HeaderSectionTitleVM(title: self.section?.title ?? "", subtitle: self.section?.subtitle ?? "")
    }

    private var headerLayoutVms: MagazineLayoutSection {
        return MagazineLayoutSection(items: [
            RowHeadlineVM(title: self.section?.title ?? "").configurator(),
            RowCaptionVM(title: self.section?.title ?? "").configurator()
        ], sectionInset: UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 16))
    }

    private var rowLayoutVms: MagazineLayoutSection {
        return MagazineLayoutSection(items: layoutItemsVms,
                                     header: .init(item: headerVms.configurator(), visibilityMode: .visible(heightMode:  headerVms.heightMode)),
                                     sectionInset: UIEdgeInsets(top: 24, left: 32, bottom: 32, right: 16))
    }

    private var cardLayoutVms: MagazineLayoutSection {
        return MagazineLayoutSection(items: [
           RowHorizontalCardsCollectionVM(items: destinationsVms,
                                          itemWidth: 136,
                                          itemHeight: 224,
                                          itemsSpacing: 8).configurator()
        ], sectionInset: UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0))
    }

    private var cardItemsVms: MagazineLayoutSection {
        return MagazineLayoutSection(items: [
           RowHorizontalCardsCollectionVM(items: destinationsVms,
                                          itemWidth: 136,
                                          itemHeight: 224,
                                          itemsSpacing: 8).configurator()
        ], sectionInset: UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0))
    }

    private var layoutItemsVms: [CellConfigurator] {
        guard let section = self.section else { return [] }
        return section.layoutItems.map { (item) in
            return RowFlightInfoVM(info: FlightInfo(departureTime: item.departureTime,
                                                    departureAirport: item.departureAirport,
                                                    arrivalTime: item.arrivalTime,
                                                    arrivalAirport: item.arrivalAirport),
                                                    step: FlowStep.Explore.page).configurator()
        }
    }

    public var destinationsVms: [CardDestinationVM] {
        return self.section?.columnItems.map { (item)  in
            CardDestinationVM(
             imageUrl: item.imageUrl,
             title: item.title,
             subtitle: item.subtitle,
             step: FlowStep.Explore.page)
        } ?? []
    }
}
