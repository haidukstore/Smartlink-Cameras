//
//  LoginViewModel.swift
//  Smartlink Cameras
//
//  Created by SecureNet Mobile Team on 1/10/20.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class LoginViewModel: ViewModelProtocol {
    
    typealias Dependency = HasUserService
    
    struct Bindings {
        let loginButtonTap: Observable<Void>
        let usernameInputing: Observable<String>
    }
    
    let loginResult: Observable<Void>
    let usernameBaseURL: Observable<Result<UserBaseURL, APIError>>
    let isLoading: Observable<Bool>
    
    init(dependency: Dependency, bindings: Bindings) {
        loginResult = bindings.loginButtonTap
            .do(onNext: { _ in dependency.userService.login()  })

        let indicator = ActivityIndicator()
        isLoading = indicator.asObservable()

        usernameBaseURL = bindings.usernameInputing
            .flatMap { baseURL in
                dependency.userService.checkUserBaseURL(name: baseURL)
                    .observeOn(MainScheduler.instance)
                    .trackActivity(indicator)
        }
    }
    
    deinit {
        
    }
    
}
