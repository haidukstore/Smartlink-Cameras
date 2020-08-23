//
//  LabeledCheckBox.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 23.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import UIKit
import RxSwift

//MARK: LabeledCheckBoxx
class LabeledCheckBox: UIView  {
    
    private let checkBox = CheckBox().config { $0.state = .unchecked }
    
    public let label = UILabel()
    
    private let disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initDefault()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDefault()
    }
    
    private func initDefault() {
        
        configCheckBox()
        confidLabel()
    }
    
    private func configCheckBox() {
        
        addSubview(checkBox, constraints: [
            equal(\.leadingAnchor),
            equal(\.topAnchor),
            equal(\.bottomAnchor)
        ])
        checkBox.widthAnchor.constraint(equalTo: checkBox.heightAnchor).isActive = true
    }
    
    private func confidLabel() {
        
        addSubview(label, constraints: [
            equal(\.trailingAnchor),
            equal(\.topAnchor),
            lessThanOrEqualTo(\.bottomAnchor, offset: 0),
        ])
        checkBox.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -16).isActive = true
        
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        
        label.setContentHuggingPriority(.required, for: .vertical)
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
        setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        let tapGesture = UITapGestureRecognizer()
        addGestureRecognizer(tapGesture)

        tapGesture.rx.event.bind(onNext: { [weak self] _ in
            self?.checkBox.state.toggle()
        }).disposed(by: disposeBag)
    }
    
    public func setAction(_ action: ((Bool) -> Void)?) {
        checkBox.setAction(action)
    }
}
