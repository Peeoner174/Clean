//
//  BackgroundStyle.swift
//  CleanArhitecture
//
//  Created by MSI on 06/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

public protocol BackgroundDesignable: class {
    var style: BackgroundStyle { get }
    var didTap: ((_ recognizer: UIGestureRecognizer) -> Void)? { get set }
}

extension BackgroundDesignable where Self: UIView { }

public class DimmedView: UIView {
    private let dimAlpha: CGFloat
    
    /**
     The closure to be executed when a tap occurs
     */
    public var didTap: ((_ recognizer: UIGestureRecognizer) -> Void)?
    
    /**
     Tap gesture recognizer
     */
    private lazy var tapGesture: UIGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(didTapView))
    }()
    
    // MARK: - Event Handlers
    
    @objc private func didTapView() {
        didTap?(tapGesture)
    }

    init(dimAlpha: CGFloat = 0.7) {
        self.dimAlpha = dimAlpha
        super.init(frame: .zero)
        alpha = 0.0
        backgroundColor = .black
        addGestureRecognizer(tapGesture)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

extension DimmedView: BackgroundDesignable {
    public var style: BackgroundStyle {
        return .dimmed(alpha: self.dimAlpha)
    }
}

public class BluredView: UIVisualEffectView {
    let effectStyle: UIBlurEffect.Style
    
    /**
     The closure to be executed when a tap occurs
     */
    public var didTap: ((_ recognizer: UIGestureRecognizer) -> Void)?
    
    /**
     Tap gesture recognizer
     */
    private lazy var tapGesture: UIGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(didTapView))
    }()
    
    // MARK: - Event Handlers
    
    @objc private func didTapView() {
        didTap?(tapGesture)
    }
    
    init(effectStyle: UIBlurEffect.Style) {
        self.effectStyle = effectStyle
        super.init(effect: UIBlurEffect(style: effectStyle))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BluredView: BackgroundDesignable {
    public var style: BackgroundStyle {
        return .blurred(effectStyle: self.effectStyle)
    }
}


class PassthroughBackgroundView: UIView {
    var passthroughViews: [UIView] = []
    var shouldPassthrough = true
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = super.hitTest(point, with: event)
        
        if !shouldPassthrough {
            return view
        }
        
        if view == self {
            for passthroughView in passthroughViews {
                view = passthroughView.hitTest(convert(point, to: passthroughView), with: event)
                if view != nil {
                    break
                }
            }
        }
        
        return view
    }
    
}

extension PassthroughBackgroundView: BackgroundDesignable {
    var style: BackgroundStyle {
        return .clear(shouldPassthrough: shouldPassthrough)
    }
    
    var didTap: ((UIGestureRecognizer) -> Void)? {
        get {
            <#code#>
        }
        set {
            <#code#>
        }
    }
}



public enum BackgroundStyle {
    case dimmed(alpha: CGFloat)
    case blurred(effectStyle: UIBlurEffect.Style)
    case clear(shouldPassthrough: Bool)
}

