//
//  APIService.swift
//  Smartlink Cameras
//
//  Created by SecureNet Mobile Team on 1/10/20.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import Foundation
import RxSwift

protocol APIServiceProtocol {

    func request<T: Decodable>(with api: API) ->  Observable<T>
}

final class APIService: APIServiceProtocol {


    let session: URLSession

    init( ) {
        session = URLSession.shared
    }
    
    func request<T: Decodable>(with api: API) -> Observable<T> {

        return Observable<T>.create { [unowned self] observer in

            var request = URLRequest(url: URL(string: api.baseURL)!)
            request.httpMethod = api.method.rawValue

            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: api.parameters, options: .prettyPrinted)
            }
            catch {
                assertionFailure("Request body is invalid: \(Self.self) line: \(#line)")
                observer.onError(APIError.invalidData)
            }

            let task = self.session.dataTask(with: request) { (data, response, error) in

                do {
                    response.get
                    let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                    observer.onNext(model)
                }
                catch {
                    observer.onError(APIError.invalidResponse)
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
