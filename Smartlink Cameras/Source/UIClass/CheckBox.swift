//
//  CheckBox.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 23.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import UIKit
import RxSwift

//MARK: CheckBox
class CheckBox: UIView {
    
    typealias onCheck = (Bool) -> Void

    enum State {
        case checked, unchecked
        
        mutating func toggle() {
            self = self == .checked ? .unchecked : .checked
        }
    }
    
    //MARK: Properties
    private let button = UIButton(type: .custom)
    
    public var checkImage = UIImage(named: "icon-checkedbox")
    
    public var uncheckImage = UIImage(named: "icon-uncheckedbox")
    
    private var onStateChange: onCheck?
    
    var state: State = .unchecked {
        
        willSet {
            switch newValue {
            case .checked:
                setChecked()
            case .unchecked:
                setUnchecked()
            }
        }
    }
    
    private let disposeBag = DisposeBag()
    
    //MARK: Func
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDefault()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initDefault()
    }
    
    fileprivate func initDefault() {
        addSubview(button, constraints: [
            equal(\.leadingAnchor),
            equal((\.topAnchor)),
            equal(\.trailingAnchor),
            equal(\.bottomAnchor)
        ])
        
        button.adjustsImageWhenHighlighted = false
        button.imageView?.contentMode = .scaleAspectFill
        
        button.rx
            .tap
            .subscribe { [weak self] _ in
                self?.state.toggle()
                self?.onStateChange?(self?.state == .checked)
        }.disposed(by: disposeBag)
    }
    
    fileprivate func setChecked() {
        button.setImage(checkImage, for: .normal)
        button.imageView?.tintColor = .orange
        onStateChange?(true)
    }
    
    fileprivate func setUnchecked() {
        button.setImage(uncheckImage, for: .normal)
        button.imageView?.tintColor = .lightGray
        onStateChange?(false)
    }
    
    public func setAction(_ action: onCheck?) {
        onStateChange = action
    }
}
