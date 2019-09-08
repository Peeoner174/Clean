//
//  PopOverContainerView.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

/**
 A view wrapper around the presented view in a PanModal transition.
 
 This allows us to make modifications to the presented view without
 having to do those changes directly on the view
 */
class PopOverContainerView: UIView {
    
    init(presentedView: UIView, frame: CGRect) {
        super.init(frame: frame)
        addSubview(presentedView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView {
    
    /**
     Convenience property for retrieving a PanContainerView instance
     from the view hierachy
     */
    var popOverContainerView: PopOverContainerView? {
        return subviews.first(where: { view -> Bool in
            view is PopOverContainerView
        }) as? PopOverContainerView
    }
    
}
