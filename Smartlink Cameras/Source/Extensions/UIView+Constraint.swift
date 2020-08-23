//
//  UIView+Constraint.swift
//  Smartlink Cameras
//
//  Created by Roman Haiduk on 22.08.2020.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import UIKit


typealias Constraint = (_ child: UIView, _ parent: UIView) -> NSLayoutConstraint

extension UIView {
    
    func addSubview(_ view: UIView, constraints: [Constraint]) {
           addSubview(view)
           view.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(constraints.map { c in
               c(view, self)
           })
       }
}

func equal<L>(_ to: KeyPath<UIView, L>, equalToConstant: CGFloat) -> Constraint  where L: NSLayoutDimension {
    return { view, parent in
        view[keyPath: to].constraint(equalToConstant: equalToConstant)
    }
}

func equal<L, Axis>(_ to: KeyPath<UIView, L>) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: to].constraint(equalTo: parent[keyPath: to])
    }
}

func equal<L, Axis>(_ to: KeyPath<UIView, L>, offset: CGFloat) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: to].constraint(equalTo: parent[keyPath: to], constant: offset)
    }
}

func equal<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: from].constraint(equalTo: parent[keyPath: to])
    }
}

func equal<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, offset: CGFloat) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: from].constraint(equalTo: parent[keyPath: to], constant: offset)
    }
}

func greaterThanOrEqualTo<L, Axis>(_ to: KeyPath<UIView, L>, offset: CGFloat) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: to].constraint(greaterThanOrEqualTo:  parent[keyPath: to], constant: offset)
    }
}

func greaterThanOrEqualTo<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, offset: CGFloat) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: from].constraint(greaterThanOrEqualTo:  parent[keyPath: to], constant: offset)
    }
}

func lessThanOrEqualTo<L, Axis>(_ to: KeyPath<UIView, L>, offset: CGFloat) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: to].constraint(lessThanOrEqualTo:  parent[keyPath: to], constant: offset)
    }
}

func lessThanOrEqualTo<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, offset: CGFloat) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view, parent in
        view[keyPath: from].constraint(lessThanOrEqualTo:  parent[keyPath: to], constant: offset)
    }
}

func equal<L>(_ to: KeyPath<UIView, L>, multiplier: CGFloat) -> Constraint where L: NSLayoutDimension {
    return { view, parent in
        view[keyPath: to].constraint(equalTo:  parent[keyPath: to], multiplier: multiplier)
    }
}

func equal<L>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, multiplier: CGFloat) -> Constraint where L: NSLayoutDimension{
    return { view, parent in
        view[keyPath: to].constraint(equalTo: parent[keyPath: to], multiplier: multiplier)
    }
}
