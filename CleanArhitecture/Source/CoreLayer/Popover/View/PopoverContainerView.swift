//
//  PopOverContainerView.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class PopoverContainerView: UIView {
    
    weak var presentedView: UIView?
    weak var dragindicatorView: UIView?
    
    init(presentedView: UIView, frame: CGRect, dragIndicatorView: UIView? = nil) {
        super.init(frame: frame)
        self.presentedView = presentedView
        self.dragindicatorView = dragIndicatorView
        
        addSubview(presentedView)
        guard let dragIndicatorView = dragIndicatorView else { return }

        presentedView.addSubview(dragIndicatorView, constraints: [
            equal(\.bottomAnchor, to: presentedView, \.topAnchor, constant: 10),
            equal(\.leadingAnchor, to: presentedView),
            equal(\.trailingAnchor, to: presentedView),
            equal(\.topAnchor, to: presentedView, \.topAnchor, constant: -24)
        ])
    }
    
    deinit {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
