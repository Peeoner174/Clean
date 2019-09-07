//
//  PassthroughBackgroundView.swift
//  CleanArhitecture
//
//  Created by MSI on 07/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class PassthroughBackgroundView: UIView {
    var passthroughViews: [UIView] = []
    var shouldPassthrough = true
    
    init(shouldPassthrough: Bool) {
        self.shouldPassthrough = shouldPassthrough
        super.init(frame: .zero)
        if shouldPassthrough {
            addGestureRecognizer(tapGesture)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
}

extension PassthroughBackgroundView: BackgroundDesignable {
    func onPresent() {
        
    }
    
    func onDissmis() {
        
    }
    
    var style: BackgroundStyle {
        return .clear(shouldPassthrough: shouldPassthrough)
    }
}

