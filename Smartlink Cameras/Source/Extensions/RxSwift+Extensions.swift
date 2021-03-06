//
//  RxSwift+Extensions.swift
//  Smartlink
//
//  Created by Minhaz Mohammad on 8/13/18.
//  Copyright © 2018 SecureNet Technologies, LLC. All rights reserved.
//

import RxCocoa
import RxSwift

extension ObservableType {
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map({ _ in })
    }

    func startLoading(on observable: PublishRelay<Bool>) -> Self {
        observable.accept(true)
        return self
    }

    func stopLoading(on observable: PublishRelay<Bool>) -> Self {
        observable.accept(false)
        return self
    }
}
