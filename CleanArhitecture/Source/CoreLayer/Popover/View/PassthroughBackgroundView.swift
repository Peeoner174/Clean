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
    
    init(shouldPassthrough: Bool, presentingVC: UIViewController) {
        self.shouldPassthrough = shouldPassthrough
        self.passthroughViews = presentingVC.view.subviews
        super.init(frame: .zero)
        if !shouldPassthrough {
            addGestureRecognizer(tapGesture)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getNavigationBar(fromViewsStack viewsStack: [UIView]) -> UINavigationBar? {
        viewsStack.filter {$0.isKind(of: UINavigationBar.classForCoder()) }.first as? UINavigationBar
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = super.hitTest(point, with: event)
        
        guard shouldPassthrough else { return view }
        
        if let navigationBar = self.getNavigationBar(fromViewsStack: passthroughViews),
           navigationBar.bounds.contains(convert(point, to: navigationBar)) {
            view = navigationBar.hitTest(convert(point, to: navigationBar), with: event)
        } else if view == self {
            for passthroughView in passthroughViews {
                view = passthroughView.hitTest(convert(point, to: passthroughView), with: event)
                if view != nil {
                    break
                }
            }
        }
        
        return view
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

extension PassthroughBackgroundView: BackgroundDesignable {
    
    func onDissmis() {
        
    }
    
    var style: BackgroundStyle {
        return .clear(shouldPassthrough: shouldPassthrough)
    }
}

