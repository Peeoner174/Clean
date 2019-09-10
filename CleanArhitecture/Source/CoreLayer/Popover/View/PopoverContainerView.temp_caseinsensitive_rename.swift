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
 
 For make modifications to the presented view without
 having to do those changes directly on the view
 */
class PopoverContainerView: UIView {
    
    init(presentedView: UIView, frame: CGRect) {
        super.init(frame: frame)
        addSubview(presentedView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView {
    
    var popOverContainerView: PopoverContainerView? {
        return subviews.first(where: { view -> Bool in
            view is PopoverContainerView
        }) as? PopoverContainerView
    }
    
}
