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

    func request<T: Decodable>(with api: API) ->  Observable<Result<T, APIError>>
}

final class APIService: APIServiceProtocol {


    let session: URLSession

    init( ) {
        session = URLSession.shared
    }
    
    func request<T: Decodable>(with api: API) -> Observable<Result<T, APIError>> {

        return Observable<Result<T, APIError>>.create { [unowned self] observer in

            var request = URLRequest(url: URL(string: api.baseURL)!)
            request.httpMethod = api.method.rawValue

            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: api.parameters, options: .prettyPrinted)
            }
            catch {
                assertionFailure("Request body is invalid: \(Self.self) line: \(#line)")
                observer.onNext(.failure(APIError.invalidData))
            }

            let task = self.session.dataTask(with: request) { (data, response, error) in

                do {

                    if let error = error as NSError? {
                        observer.onNext(.failure(.domainError(error.localizedDescription)))
                        return
                    }

                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                        observer.onNext(.failure(APIError.invalidResponse))
                        return
                    }

                    if statusCode == 200 {
                        let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                        observer.onNext(.success(model))
                    } else {
                        let errorEntity = try JSONDecoder().decode(ResponseErrorEntity.self, from: data ?? Data())
                        observer.onNext(.failure(APIError.serverError(errorEntity.error)))
                    }
                }
                catch {
                    observer.onNext(.failure(APIError.invalidResponse))
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
