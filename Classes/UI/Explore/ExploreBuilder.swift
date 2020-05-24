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
    private var sectionItems: [MagazineLayoutSection] = []
    private let bag = DisposeBag()
    let steps = PublishRelay<Step>()

    public func build(section: Section) -> [MagazineLayoutSection] {
         let header = HeaderSectionTitleVM(title: "Last visited", subtitle: "Your last visited destinations")
         let destinationsLayout: [CardDestinationVM] = section.columnItems.map { (item)  in
             return CardDestinationVM(
              imageUrl: item.imageUrl,
              title: item.title,
              subtitle: item.subtitle,
              step: FlowStep.Explore.page)
         }

         destinationsLayout.forEach {
            $0.steps.bind(to: self.steps).disposed(by: bag)
         }

         let headerLayout = MagazineLayoutSection(items: [
                            RowHeadline1VM(title: section.title).configurator(),
                            RowCaptionVM(title: section.title).configurator()
         ], sectionInset: UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 16))
         sectionItems.append(headerLayout)

         let cardLayout = MagazineLayoutSection(items: [
             RowHorizontalCardsCollectionVM(items: destinationsLayout,
                                                           itemWidth: 136,
                                                           itemHeight: 224,
                                                           itemsSpacing: 8).configurator()
         ], sectionInset: UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0))
         sectionItems.append(cardLayout)

         let layoutItems: [CellConfigurator] = section.layoutItems.map { (item) in
             return RowFlightInfoVM(info: FlightInfo(departureTime: item.departureTime,
                                              departureAirport: item.departureAirport,
                                              arrivalTime: item.arrivalTime,
                                              arrivalAirport: item.arrivalAirport)).configurator()

         }

         let rowLayout = MagazineLayoutSection(items: layoutItems,
                               header: .init(item: header.configurator(), visibilityMode: .visible(heightMode: header.heightMode)),
                               sectionInset: UIEdgeInsets(top: 24, left: 32, bottom: 32, right: 16))
         sectionItems.append(rowLayout)
         return sectionItems
    }
}
