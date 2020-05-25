//
//  CardDestinationVM.swift
//  Chili Labs
//
//  Generated by Chigevara on 13/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import MagazineLayout
import RxFlow
import RxSwift
import RxCocoa

class CardDestinationVM: MagazineCellDataType, StepSupportable {
    var sizeMode: MagazineLayoutItemSizeMode {
        return MagazineLayoutItemSizeMode(widthMode: .thirdWidth, heightMode: .static(height: 160))
    }

    let imageUrl: String
    let title: String
    let subtitle: String
    let defaultStep: Step
    let steps = PublishRelay<Step>()

    init(imageUrl: String, title: String, subtitle: String, step: Step) {
        self.imageUrl = imageUrl
        self.title = title
        self.subtitle = subtitle
        self.defaultStep = step
    }

    var diffHash: Int {
        return imageUrl.hashValue
    }

    func configurator() -> CellConfigurator {
        return CardDestinationConfigurator(item: self)
    }

    func didSelect() {
        self.steps.accept(defaultStep)
    }
}

