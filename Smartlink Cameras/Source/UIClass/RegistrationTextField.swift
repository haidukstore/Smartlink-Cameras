//
//  RegistrationTextField.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 23.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import UIKit
import RxSwift

/// Сustom offset of bottom line.
public struct BorderOffset {
    let x: CGFloat
    let y: CGFloat
    
    public static let zero = BorderOffset(x: 0, y: 0)
}

class RegistrationTextField: UITextField {
    
    typealias Line = UIView
    
    //MARK: Properties
    
    private var line = Line()
    public var borderOffset: BorderOffset = .zero
    
    public var lineColor: UIColor {
        get {
            return line.backgroundColor ?? .textfieldTintColor
        } set {
            line.backgroundColor = newValue
        }
    }
    
    fileprivate var _lineWidth: CGFloat = 1 {
        willSet {
            lineWidthConstraint?.constant = newValue
        }
    }
    
    public var lineWidth: CGFloat {
        get {
            return _lineWidth
        } set {
            _lineWidth = newValue
        }
    }
    
    override var placeholder: String? {
        get {
            attributedPlaceholder?.string
        }
        set {
            attributedPlaceholder = NSAttributedString(string: newValue ?? "", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
            ])
        }
    }
    
    fileprivate var lineWidthConstraint: NSLayoutConstraint?
    
    fileprivate let keyboardFrameObserver = PublishSubject<CGRect>()
    
    public var onKeyboardChangeFrame: Observable<CGRect> {
        keyboardFrameObserver.asObservable()
    }

    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDefault()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initDefault()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func initDefault() {
        autocorrectionType = .no
        borderStyle = .none
        textColor = .darkGray
        font = .systemFont(ofSize: 17)
        
        configureBottomLine()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        // To obtain the size of the keyboard:
        let newRect =  (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrameObserver.onNext(newRect)
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        keyboardFrameObserver.onNext(.zero)
    }
    
    //MARK: Config functions
    
    private func configureBottomLine() {
        line.backgroundColor = .textfieldTintColor
        
       addSubview(line, constraints: [
        equal(\.bottomAnchor, offset: -borderOffset.y),
        equal(\.leadingAnchor, offset: borderOffset.x),
        equal(\.trailingAnchor, offset: borderOffset.x),
       ])
        
        lineWidthConstraint = line.heightAnchor.constraint(equalToConstant: lineWidth)
        lineWidthConstraint?.isActive = true
    }
}
