//
//  ApiClient.swift
//  DesignSystemExample
//
//  Created by SEYHUN AKYÜREK on 24.05.2020.
//  Copyright © 2020 Chili Labs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ApiConfig {
   static let urlDebug = URL(string: "http://localhost:3000")!
   static let urlLive = URL(string: "https://live:3000")!
}

class ApiClient {
    func send<T: Codable>(apiRequest: ApiRequest) -> Observable<T> {
        var url = ApiConfig.urlDebug
        if Api.shared.envMode == Mode.Live {
            url = ApiConfig.urlLive
        }

        return Observable<T>.create { observer in
            let request = apiRequest.request(with: url)
            Logger.log(request: request)

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    Logger.log(data: data, response: response as? HTTPURLResponse, error: error)

                    let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(model)

                } catch _{
                    observer.onError(Exception.InvalidIntegrationException(message: ErrorMessage.errorMapping))
                }
                observer.onCompleted()
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
