//
//  SectionService.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol SectionServiceProtocol {
    func getAllSections(request : ApiRequest) -> Observable<ApiResponse<Section>>
}

class SectionService: SectionServiceProtocol {
    private let apiClient = ApiClient()

    func getAllSections(request: ApiRequest) -> Observable<ApiResponse<Section>> {
        request.path = "/sections"
        request.method = RequestType.GET
        return apiClient.send(apiRequest: request)
    }
}
