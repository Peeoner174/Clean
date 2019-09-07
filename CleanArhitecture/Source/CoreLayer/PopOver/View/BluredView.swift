//
//  BluredView.swift
//  CleanArhitecture
//
//  Created by MSI on 07/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

public class BluredView: UIVisualEffectView {
    let effectStyle: UIBlurEffect.Style
    
    init(effectStyle: UIBlurEffect.Style) {
        self.effectStyle = effectStyle
        super.init(effect: nil)
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension BluredView: BackgroundDesignable {
    public func onPresent() {
        effect = UIBlurEffect(style: effectStyle)
    }
    
    public func onDissmis() {
        effect = nil
    }
    
    public var style: BackgroundStyle {
        return .blurred(effectStyle: self.effectStyle)
    }
}
