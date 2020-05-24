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
        if isLoading {
          return
        }

        isLoading = true
        repository.getAllSections()
          .subscribe(onNext: { (result) in
              switch result.succeeded {
              case true:
                guard let section = result.data else { return }
                self.isLoading = false
                self.sectionItems = self.prepareSections(section: section)
                self.$sections.accept(self.sectionItems)
                self.onLoadComplete()
                break
              default:
                self.onError(message: Exception.InvalidIntegrationException(message: result.message!).errorDescription!)
                break
              }

          }, onError: { (error) in
              self.isLoading = false
              self.onError(message: error.localizedDescription)
            }).disposed(by: bag)
    }

    func onLoadComplete() {

    }

    func onError(message: String) {

    }

    private func prepareSections(section: Section) -> [MagazineLayoutSection] {
        let header = HeaderSectionTitleVM(title: "Last visited", subtitle: "Your last visited destinations")

        let destinationsLayout: [CardDestinationVM] = section.columnItems.map { (item)  in
            return CardDestinationVM(imageUrl: item.imageUrl, title: item.title, subtitle: item.subtitle, step: FlowStep.Explore.page)
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
