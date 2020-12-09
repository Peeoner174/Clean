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
    let maxAlpha: CGFloat
    let minAlpha: CGFloat
    
    init(effectStyle: UIBlurEffect.Style, maxAlpha: CGFloat, minAlpha: CGFloat) {
        self.effectStyle = effectStyle
        self.maxAlpha = maxAlpha
        self.minAlpha = minAlpha
        super.init(effect: nil)
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var didTap: ((_ recognizer: UIGestureRecognizer) -> Void)?
    
    private lazy var tapGesture: UIGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(didTapView))
    }()
    
    // MARK: - Event Handlers
    
    @objc private func didTapView() {
        didTap?(tapGesture)
    }
}

extension BluredView: BackgroundDesignable {
    func onPresent() {
        self.effect = UIBlurEffect(style: self.effectStyle)
    }
    
    func onDissmis() {
        effect = nil
    }
    
    var style: BackgroundStyle {
        return .blurred(effectStyle: self.effectStyle, maxAlpha: self.maxAlpha, minAlpha: self.minAlpha)
    }
    
    func updateIntensity(percent: CGFloat) {
        alpha = percent
    }
}
