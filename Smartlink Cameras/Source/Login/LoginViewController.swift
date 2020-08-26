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
        return LoginViewModel
            .Bindings(loginButtonTap: loginButton.rx.tap.asObservable(),
                      usernameInputing: usernameTextField.rx
                        .text
                        .orEmpty
                        .debounce(.seconds(1), scheduler: MainScheduler.instance)
                        .distinctUntilChanged()
                        .filter { $0 != "" }
                        )
    }
    
    var viewModel: Attachable<LoginViewModel>!
    
    func configureReactiveBinding(viewModel: LoginViewModel) -> LoginViewModel {

        viewModel.usernameBaseURL
            .subscribe(onNext: {
                print($0)
            }, onError: {
                print($0)
            }).disposed(by: disposeBag)
        
        return viewModel
    }
    
    
    // MARK: - Logic variables
    fileprivate let disposeBag = DisposeBag()
    
    
    // MARK: - UI variables
    
    fileprivate let loginButton = UIButton(type: .system).config {
        
        $0.setTitle(L("Sign In"), for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.backgroundColor = .signInButtonBackground
    }
    
    fileprivate let backgroundImageView = UIImageView(image: LoginImage.backgroundImage.image).config {
        $0.contentMode = .scaleToFill
    }
    
    fileprivate let loginImageView = UIImageView(image: LoginImage.logo.image).config {
        $0.contentMode = .scaleAspectFit
    }
    
    fileprivate let usernameTextField = RegistrationTextField().config {
        $0.placeholder = L("Username")
    }
    
    fileprivate let passwordTextField = RegistrationTextField().config {
        $0.placeholder = L("Password")
    }
    
    fileprivate let labeledCheckBox = LabeledCheckBox().config {
        $0.label.text = L("Remember Me")
    }
    
    fileprivate let forgotPasswordButton = UIButton(type: .system).config {
        $0.setTitle(L("Forgot Password?"), for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.setContentHuggingPriority(.required, for: .vertical)
    }
    
    fileprivate let bottomLabel = UILabel().config {
        let mutStr = NSMutableAttributedString()
        let firstStr = NSAttributedString(string: L("Installing a DIY System? "), attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
        let secStr = NSAttributedString(string: L("Get Started"), attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
        mutStr.append(firstStr); mutStr.append(secStr)
        $0.attributedText = mutStr
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

        configureAppearance()
        configureRx()
    }
}

extension LoginViewController {
    
    //MARK: Configure Appearance
    fileprivate func configureAppearance() {
        view.backgroundColor = .white
//Background Image
        view.addSubview(backgroundImageView, constraints: [
            equal(\.heightAnchor, multiplier: 0.5), equal(\.leadingAnchor),
            equal(\.topAnchor), equal(\.trailingAnchor)
        ])
        
        backgroundImageView.addSubview(loginImageView, constraints: [
            equal(\.centerXAnchor), equal(\.centerYAnchor, offset: 20),
            equal(\.widthAnchor, multiplier: 0.9)
        ])
//Username TextField
        view.addSubview(usernameTextField, constraints: [
            equal(\.centerXAnchor), equal(\.widthAnchor, multiplier: 0.9)
        ])
        usernameTextField.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor,
                                               constant: 36).isActive = true
 //Password TextFeild
        view.addSubview(passwordTextField, constraints: [
            equal(\.centerXAnchor), equal(\.widthAnchor, multiplier: 0.9)
        ])
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor,
                                               constant: 36).isActive = true
//Checkox with label
        view.addSubview(labeledCheckBox, constraints: [
            equal(\.leadingAnchor, offset: 24), equal(\.heightAnchor, equalToConstant: 30)
        ])
        labeledCheckBox.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                             constant: 36).isActive = true
//Forgot password button
        view.addSubview(forgotPasswordButton, constraints: [
            equal(\.trailingAnchor, offset: -30)
        ])
        labeledCheckBox.topAnchor.constraint(equalTo: forgotPasswordButton.topAnchor,
                                             constant: 6).isActive = true
        forgotPasswordButton.leadingAnchor.constraint(greaterThanOrEqualTo: labeledCheckBox.trailingAnchor,
                                                      constant: 8).isActive = true
//Bottom Label
        view.addSubview(bottomLabel, constraints: [
            equal(\.safeAreaLayoutGuide.bottomAnchor, offset: -20),
            equal(\.centerXAnchor)
        ])
//Login Button
        view.addSubview(loginButton, constraints: [
            equal(\.widthAnchor, multiplier: 0.9), equal(\.centerXAnchor),
            equal(\.heightAnchor, equalToConstant: 50)
        ])
        loginButton.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor,
                                            constant: -24).isActive = true
    }
    
    fileprivate func configureRx() {
//Move up view if need
        let keyboardObserver = Observable
            .merge(
                usernameTextField.onKeyboardChangeFrame,
                passwordTextField.onKeyboardChangeFrame)
        
        keyboardObserver.subscribe(onNext: { [unowned self] newRect in
            
            if newRect == .zero {
                self.view.frame.origin = .zero
            } else if self.view.frame.origin == .zero && newRect.height != 0{
                
                let bottommost = self.passwordTextField.frame.maxY
                let keyboardTop = self.view.bounds.height - newRect.height
                switch bottommost - keyboardTop {
                case -20..<10:
                    self.view.frame.origin.y -= 30
                case ...10 :
                    self.view.frame.origin.y -= keyboardTop - bottommost + 20
                default:
                    self.view.frame.origin.y = 0
                }
            }
        }).disposed(by: disposeBag)
//Change textfield on "Return"
        usernameTextField.rx
            .controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] in
                self?.passwordTextField.becomeFirstResponder()
            }).disposed(by: disposeBag)
        
        passwordTextField.rx
            .controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] in
               self?.usernameTextField.becomeFirstResponder()
            }).disposed(by: disposeBag)
//Hide keyboard on tap screen
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
}
