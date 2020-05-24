//
//  SectionRepository.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol SectionRepository {
    func getAllSections() -> Observable<ApiResponse<Section>>
}

class SectionRepositoryImpl: SectionRepository {
    let service = SectionService()

    func getAllSections() -> Observable<ApiResponse<Section>> {
        let request = ApiRequest()

        return service.getAllSections(request: request)
            .flatMap{
                result -> Observable<ApiResponse<Section>> in
                return result.succeeded ? Observable.just(result) : Observable.error(Exception.InvalidIntegrationException(message: result.message!))
        }
    }

}
