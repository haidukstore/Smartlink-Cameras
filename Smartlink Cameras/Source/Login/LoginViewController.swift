//
//  LoginViewController.swift
//  Smartlink Cameras
//
//  Created by SecureNet Mobile Team on 1/10/20.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import RxSwift
import UIKit

final class LoginViewController: UIViewController, ViewModelAttachingProtocol {

    // MARK: - Conformance to ViewModelAttachingProtocol
    var bindings: LoginViewModel.Bindings {
        return LoginViewModel.Bindings(loginButtonTap: loginButton.rx.tap.asObservable())
    }
    
    var viewModel: Attachable<LoginViewModel>!
    
    func configureReactiveBinding(viewModel: LoginViewModel) -> LoginViewModel {
        return viewModel
    }
    
    
    // MARK: - Logic variables
    fileprivate let disposeBag = DisposeBag()
    
    
    // MARK: - UI variables
    fileprivate var areConstraintsSet: Bool = false
    
    fileprivate let loginButton = UIButton(type: .custom).config {
        
        $0.setTitle(L("Login", comment: "Login button text"), for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate let backgroundImageView = UIImageView(image: LoginImage.backgroundImage.image).config {
        $0.contentMode = .scaleToFill
    }
    
    fileprivate let loginImageView = UIImageView(image: LoginImage.logo.image).config {
        $0.contentMode = .scaleAspectFit
    }
    
    fileprivate let usernameTextField = UITextField().config {
        $0.autocorrectionType = .no
        $0.placeholder = L("Username")
        $0.borderStyle = .line
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 17)
    }
    
    fileprivate let passwordTextField = UITextField().config {
        $0.autocorrectionType = .no
        $0.placeholder = L("Password")
        $0.borderStyle = .line
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 17)
    }
    
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureAppearance()
    }
    

    deinit {
        
    }

}

extension LoginViewController {
    
    fileprivate func configureAppearance() {
        view.backgroundColor = .white
        
        view.addSubview(backgroundImageView, constraints: [
            equal(\.heightAnchor, multiplier: 0.5), equal(\.leadingAnchor, offset: 1),
            equal(\.topAnchor), equal(\.trailingAnchor, offset: -1)
        ])
        
        backgroundImageView.addSubview(loginImageView, constraints: [
            equal(\.centerXAnchor), equal(\.centerYAnchor, offset: 20),
            equal(\.widthAnchor, multiplier: 0.75)
        ])

        view.addSubview(usernameTextField, constraints: [
            equal(\.centerXAnchor), equal(\.widthAnchor, multiplier: 0.9)
        ])
        usernameTextField.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor,
                                               constant: 30).isActive = true
        
        view.addSubview(passwordTextField, constraints: [
            equal(\.centerXAnchor), equal(\.widthAnchor, multiplier: 0.9)
        ])
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor,
                                               constant: 16).isActive = true
        
        view.addSubview(loginButton, constraints: [
            equal(\.widthAnchor, multiplier: 0.9), equal(\.centerXAnchor)
        ])
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                                      constant: 40).isActive = true
        
    }
}
