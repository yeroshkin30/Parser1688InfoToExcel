//
//  LayoutDSL.swift
//  testJSON
//
//  Created by oleh yeroshkin on 14.06.2024.
//

import AppKit

/// DSL for AutoLayout
// Protocol defining methods for creating constraints related to layout anchors
protocol LayoutAnchor {

    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}

// Protocol extending LayoutAnchor to include methods for dimension constraints
protocol LayoutDimension: LayoutAnchor {

    func constraint(equalToConstant constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualToConstant constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualToConstant constant: CGFloat) -> NSLayoutConstraint

    func constraint(equalTo anchor: Self, multiplier: CGFloat) -> NSLayoutConstraint
}

// Extend NSLayoutAnchor and NSLayoutDimension to conform to custom protocols
extension NSLayoutAnchor: LayoutAnchor {}
extension NSLayoutDimension: LayoutDimension {}

// Class representing a layout property associated with a specific layout anchor
class LayoutProperty<Anchor: LayoutAnchor> {

    fileprivate let anchor: Anchor
    fileprivate let kind: Kind

    enum Kind { case leading, trailing, top, bottom, centerX, centerY, width, height }

    init(anchor: Anchor, kind: Kind) {
        self.anchor = anchor
        self.kind = kind
    }
}

// Subclass of LayoutProperty specifically for dimension properties (width, height)
class LayoutAttribute<Dimension: LayoutDimension>: LayoutProperty<Dimension> {

    fileprivate let dimension: Dimension

    init(dimension: Dimension, kind: Kind) {
        self.dimension = dimension
        super.init(anchor: dimension, kind: kind)
    }
}

// Class to provide lazy-initialized layout properties for a NSView
final class LayoutProxy {

    lazy var leading = property(with: view.leadingAnchor, kind: .leading)
    lazy var trailing = property(with: view.trailingAnchor, kind: .trailing)
    lazy var top = property(with: view.topAnchor, kind: .top)
    lazy var bottom = property(with: view.bottomAnchor, kind: .bottom)
    lazy var centerX = property(with: view.centerXAnchor, kind: .centerX)
    lazy var centerY = property(with: view.centerYAnchor, kind: .centerY)
    lazy var width = attribute(with: view.widthAnchor, kind: .width)
    lazy var height = attribute(with: view.heightAnchor, kind: .height)

    private let view: NSView

    fileprivate init(view: NSView) {
        self.view = view
    }

    // Helper method to create a LayoutProperty for a given anchor
    private func property<A: LayoutAnchor>(with anchor: A, kind: LayoutProperty<A>.Kind) -> LayoutProperty<A> {
        return LayoutProperty(anchor: anchor, kind: kind)
    }

    // Helper method to create a LayoutAttribute for a given dimension
    private func attribute<D: LayoutDimension>(with dimension: D, kind: LayoutProperty<D>.Kind) -> LayoutAttribute<D> {
        return LayoutAttribute(dimension: dimension, kind: kind)
    }
}

// Extension to add methods for setting constraints on LayoutAttribute instances
extension LayoutAttribute {

    @discardableResult
    func equal(to constant: CGFloat, priority: NSLayoutConstraint.Priority? = nil) -> NSLayoutConstraint {
        let constraint = dimension.constraint(equalToConstant: constant)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func equal(to otherDimension: Dimension,
               multiplier: CGFloat,
               priority: NSLayoutConstraint.Priority? = nil) -> NSLayoutConstraint {
        let constraint = dimension.constraint(equalTo: otherDimension, multiplier: multiplier)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func greaterThanOrEqual(to constant: CGFloat, priority: NSLayoutConstraint.Priority? = nil) -> NSLayoutConstraint {
        let constraint = dimension.constraint(greaterThanOrEqualToConstant: constant)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func lessThanOrEqual(to constant: CGFloat, priority: NSLayoutConstraint.Priority? = nil) -> NSLayoutConstraint {
        let constraint = dimension.constraint(lessThanOrEqualToConstant: constant)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }
}

// Extension to add methods for setting constraints on LayoutProperty instances
extension LayoutProperty {

    @discardableResult
    func equal(to otherAnchor: Anchor,
               offsetBy constant: CGFloat = 0,
               priority: NSLayoutConstraint.Priority? = nil) -> NSLayoutConstraint {
        let constraint = anchor.constraint(equalTo: otherAnchor, constant: constant)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func greaterThanOrEqual(to otherAnchor: Anchor,
                            offsetBy constant: CGFloat = 0,
                            priority: NSLayoutConstraint.Priority? = nil) -> NSLayoutConstraint {
        let constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func lessThanOrEqual(to otherAnchor: Anchor,
                         offsetBy constant: CGFloat = 0,
                         priority: NSLayoutConstraint.Priority? = nil) -> NSLayoutConstraint {
        let constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant)
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = true
        return constraint
    }
}

extension NSView {

    /// Layout without adding to superview.
    func layout(using closure: (LayoutProxy) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }

    /// Added as subview to `superview` and setup constraints.
    func layout(in superview: NSView, using closure: (LayoutProxy) -> Void) {
        superview.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }

    /// Layout in superview's bounds without adding to subviews.
    func layout(to superview: NSView) {
        translatesAutoresizingMaskIntoConstraints = false
        layout { proxy in
            proxy.bottom == superview.bottomAnchor
            proxy.top == superview.topAnchor
            proxy.leading == superview.leadingAnchor
            proxy.trailing == superview.trailingAnchor
        }
    }

    /// Add this view to superview and clip it edges. Can set custom insets for each side.
    func layout(in superview: NSView, with insets: NSEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)) {
        superview.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        layout { proxy in
            proxy.bottom == superview.bottomAnchor - insets.bottom
            proxy.top == superview.topAnchor + insets.top
            proxy.leading == superview.leadingAnchor + insets.left
            proxy.trailing == superview.trailingAnchor - insets.right
        }
    }

    /// Added as subview to `superview` and clipped to its `safeAreaLayoutGuide`.
    func layoutToSafeArea(in superview: NSView) {
        superview.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        layout { proxy in
            proxy.bottom == superview.safeAreaLayoutGuide.bottomAnchor
            proxy.top == superview.safeAreaLayoutGuide.topAnchor
            proxy.leading == superview.safeAreaLayoutGuide.leadingAnchor
            proxy.trailing == superview.safeAreaLayoutGuide.trailingAnchor
        }
    }

    /// Added as subview to `superview` and set custom inset for all edges.
    func layout(in superview: NSView, allEdges insets: CGFloat) {
        superview.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        layout { proxy in
            proxy.bottom == superview.bottomAnchor - insets
            proxy.top == superview.topAnchor + insets
            proxy.leading == superview.leadingAnchor + insets
            proxy.trailing == superview.trailingAnchor - insets
        }
    }
}

func + <A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, rhs)
}

func - <A: LayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, -rhs)
}

/// Custom operator for NSLayoutConstraint.Priority - "~".
/// Example:
/// myView.layout(in: view) {
///    $0.top == view.topAnchor
///    $0.bottom <= view.bottomAnchor - 20
///    $0.bottom == anotherView.bottomAnchor + 20 ~ .defaultHigh   <<--
///    $0.leading == view.leadingAnchor + 10
///    $0.trailing == view.trailingAnchor - 10
/// }
infix operator ~: AdditionPrecedence

func ~ <A: LayoutAnchor>(lhs: A, rhs: NSLayoutConstraint.Priority) -> (A, NSLayoutConstraint.Priority) {
    return (lhs, rhs)
}

func ~ <A: LayoutAnchor>(lhs: (A, CGFloat), rhs: NSLayoutConstraint.Priority) -> ((A, CGFloat), NSLayoutConstraint.Priority) {
    return (lhs, rhs)
}

func ~ (lhs: CGFloat, rhs: NSLayoutConstraint.Priority) -> (CGFloat, NSLayoutConstraint.Priority) {
    return (lhs, rhs)
}

@discardableResult

// MARK: - ==

func == <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
func == <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: ((A, CGFloat), NSLayoutConstraint.Priority)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0.0, offsetBy: rhs.0.1, priority: rhs.1)
}

@discardableResult
func == <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, NSLayoutConstraint.Priority)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0, priority: rhs.1)
}

@discardableResult
func == <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
    return lhs.equal(to: rhs)
}

// MARK: - >=

@discardableResult
func >= <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}

@discardableResult
func >= <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
func >= <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: ((A, CGFloat), NSLayoutConstraint.Priority)) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs.0.0, offsetBy: rhs.0.1, priority: rhs.1)
}

@discardableResult
func >= <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, NSLayoutConstraint.Priority)) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs.0, priority: rhs.1)
}

// MARK: - <=

@discardableResult
func <= <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

@discardableResult
func <= <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
func <= <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: ((A, CGFloat), NSLayoutConstraint.Priority)) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs.0.0, offsetBy: rhs.0.1, priority: rhs.1)
}

@discardableResult
func <= <A: LayoutAnchor>(lhs: LayoutProperty<A>, rhs: (A, NSLayoutConstraint.Priority)) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs.0, priority: rhs.1)
}

// MARK: - Dimensions
// MARK: - ==
@discardableResult
func == <D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.equal(to: rhs)
}

@discardableResult
func == <D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: (CGFloat, NSLayoutConstraint.Priority)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0, priority: rhs.1)
}

@discardableResult
func == <D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: LayoutAttribute<D>) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.dimension)
}

// MARK: - *= Multiply

@discardableResult
func *= <D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: (D, CGFloat)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0, multiplier: rhs.1)
}

@discardableResult
func *= <D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: (LayoutAttribute<D>, CGFloat)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0.dimension, multiplier: rhs.1)
}

@discardableResult
func *= <D: LayoutDimension>(lhs: LayoutAttribute<D>,
                             rhs: ((D, CGFloat), NSLayoutConstraint.Priority)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0.0, multiplier: rhs.0.1, priority: rhs.1)
}

// MARK: - >=

@discardableResult
func >= <D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}
@discardableResult
func >= <D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: (CGFloat, NSLayoutConstraint.Priority)) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs.0, priority: rhs.1)
}

// MARK: - <=

@discardableResult
func <= <D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

@discardableResult
func <= <D: LayoutDimension>(lhs: LayoutAttribute<D>, rhs: (CGFloat, NSLayoutConstraint.Priority)) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs.0, priority: rhs.1)
}
