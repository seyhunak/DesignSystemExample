//
//  RowTextVM.swift
//  Chili Labs
//
//  Generated by Chigevara on 14/05/2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import MagazineLayout
import RxFlow
import RxSwift
import RxCocoa

struct RowTextVM: MagazineCellDataType {

    var sizeMode: MagazineLayoutItemSizeMode {
        return MagazineLayoutItemSizeMode(widthMode: .fullWidth(respectsHorizontalInsets: true),
                                          heightMode: .dynamic)
    }

    let text: String

    init(text: String) {
        self.text = text
    }

    var diffHash: Int {
        return text.hashValue
    }

    func configurator() -> CellConfigurator {
        return RowTextConfigurator(item: self)
    }

    func didSelect() {
        //
    }
}

