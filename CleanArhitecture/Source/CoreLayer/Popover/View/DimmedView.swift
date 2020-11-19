//
//  DimmedView.swift
//  CleanArhitecture
//
//  Created by MSI on 07/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

public class DimmedView: UIView {
    private let dimAlpha: CGFloat
    
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
    
    var didTap: ((_ recognizer: UIGestureRecognizer) -> Void)?
    
    private lazy var tapGesture: UIGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(didTapView))
    }()
    
    // MARK: - Event Handlers
    
    @objc private func didTapView() {
        didTap?(tapGesture)
    }
}

extension DimmedView: BackgroundDesignable {
    func onPresent() {
        alpha = dimAlpha
    }
    
    func onDissmis() {
        alpha = 0.0
    }
    
    var style: BackgroundStyle {
        return .dimmed(alpha: self.dimAlpha)
    }
}
