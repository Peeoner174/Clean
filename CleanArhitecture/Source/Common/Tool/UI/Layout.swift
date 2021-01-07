//
//  Layout.swift
//  Taxifon Driver
//
//  Created by Pavel Kochenda on 23.04.2020.
//  Copyright © 2020 Appgranula. All rights reserved.
//

import UIKit

typealias Constraint = (_ child: UIView, _ other: UIView) -> NSLayoutConstraint

// MARK: greaterThanOrEqual

func greaterThanOrEqual<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return greaterThanOrEqual(keyPath, keyPath, constant: constant, priority: priority)
}

func greaterThanOrEqual<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, _ toAnchor: KeyPath<UIView, Anchor>, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return [{ view, other in
        let constraint = view[keyPath: keyPath].constraint(greaterThanOrEqualTo: other[keyPath: toAnchor], constant: constant)
        constraint.priority = priority
        return constraint
    }]
}

func greaterThanOrEqual<Anchor>(_ keyPath: KeyPath<UIView, Anchor>, multiplier: CGFloat, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutDimension {
    return greaterThanOrEqual(keyPath, keyPath, multiplier: multiplier, constant: constant)
}

func greaterThanOrEqual<Anchor>(_ keyPath: KeyPath<UIView, Anchor>, _ toAnchor: KeyPath<UIView, Anchor>, multiplier: CGFloat, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutDimension {
    return [{ view, other in
        view[keyPath: keyPath].constraint(greaterThanOrEqualTo: other[keyPath: toAnchor], multiplier: multiplier, constant: constant)
    }]
}
func greaterThanOrEqual<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, to: UIView, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return greaterThanOrEqual(keyPath, to: to, keyPath, constant: constant)
}

func greaterThanOrEqual<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, to: UIView, _ toAnchor: KeyPath<UIView, Anchor>, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return [{ view, _ in
        view[keyPath: keyPath].constraint(greaterThanOrEqualTo: to[keyPath: toAnchor], constant: constant)
    }]
}

// MARK: lessThanOrEqual

func lessThanOrEqual<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return lessThanOrEqual(keyPath, keyPath, constant: constant, priority: priority)
}

func lessThanOrEqual<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, _ toAnchor: KeyPath<UIView, Anchor>, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return [{ view, other in
        let constraint = view[keyPath: keyPath].constraint(lessThanOrEqualTo: other[keyPath: toAnchor], constant: constant)
        constraint.priority = priority
        return constraint
    }]
}

func lessThanOrEqual<Anchor>(_ keyPath: KeyPath<UIView, Anchor>, multiplier: CGFloat, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutDimension {
    return lessThanOrEqual(keyPath, keyPath, multiplier: multiplier, constant: constant)
}

func lessThanOrEqual<Anchor>(_ keyPath: KeyPath<UIView, Anchor>, _ toAnchor: KeyPath<UIView, Anchor>, multiplier: CGFloat, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutDimension {
    return [{ view, other in
        view[keyPath: keyPath].constraint(lessThanOrEqualTo: other[keyPath: toAnchor], multiplier: multiplier, constant: constant)
    }]
}
func lessThanOrEqual<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, to: UIView, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return lessThanOrEqual(keyPath, to: to, keyPath, constant: constant)
}

func lessThanOrEqual<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, to: UIView, _ toAnchor: KeyPath<UIView, Anchor>, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return [{ view, _ in
        view[keyPath: keyPath].constraint(lessThanOrEqualTo: to[keyPath: toAnchor], constant: constant)
    }]
}

// MARK: equal

func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return equal(keyPath, keyPath, constant: constant, priority: priority)
}

func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, _ toAnchor: KeyPath<UIView, Anchor>, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return [{ view, other in
        let constraint = view[keyPath: keyPath].constraint(equalTo: other[keyPath: toAnchor], constant: constant)
        constraint.priority = priority
        return constraint
    }]
}

func equal<Anchor>(_ keyPath: KeyPath<UIView, Anchor>, multiplier: CGFloat, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutDimension {
    return equal(keyPath, keyPath, multiplier: multiplier, constant: constant)
}

func equal<Anchor>(_ keyPath: KeyPath<UIView, Anchor>, _ toAnchor: KeyPath<UIView, Anchor>, multiplier: CGFloat, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutDimension {
    return [{ view, other in
        view[keyPath: keyPath].constraint(equalTo: other[keyPath: toAnchor], multiplier: multiplier, constant: constant)
    }]
}
func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, to: UIView, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return equal(keyPath, to: to, keyPath, constant: constant)
}

func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, to: UIView, _ toAnchor: KeyPath<UIView, Anchor>, constant: CGFloat = 0) -> [Constraint] where Anchor: NSLayoutAnchor<Axis> {
    return [{ view, _ in
        view[keyPath: keyPath].constraint(equalTo: to[keyPath: toAnchor], constant: constant)
    }]
}

func constant<Anchor>(_ keyPath: KeyPath<UIView, Anchor>, constant: CGFloat, priority: UILayoutPriority = .required) -> [Constraint] where Anchor: NSLayoutDimension {
    return [{ view, _ in
        let constraint = view[keyPath: keyPath].constraint(equalToConstant: constant)
        constraint.priority = priority
        return constraint
    }]
}

func pinAllEdges(margin: CGFloat = 0) -> [Constraint] {
    return pinHorizontalEdges(margin: margin) + pinVerticalEdges(margin: margin)
}

func pinHorizontalEdges(margin: CGFloat = 0) -> [Constraint] {
    return equal(\.leadingAnchor, constant: margin) + equal(\.trailingAnchor, constant: -margin)
}

func pinVerticalEdges(margin: CGFloat = 0) -> [Constraint] {
    return equal(\.topAnchor, constant: margin) + equal(\.bottomAnchor, constant: -margin)
}

func pinToCenter() -> [Constraint] {
    return equal(\.centerXAnchor) + equal(\.centerYAnchor)
}

func pinToCenter(of view: UIView) -> [Constraint] {
    return equal(\.centerXAnchor, to: view) + equal(\.centerYAnchor, to: view)
}

extension UIView {
    func addSubview(_ child: UIView, constraints: [[Constraint]]) {
        addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints.flatMap { $0.map { $0(child, self) } })
    }
}
