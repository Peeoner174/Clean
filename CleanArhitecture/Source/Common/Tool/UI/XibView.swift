//
//  XibView.swift
//  CleanArhitecture
//
//  Created by MSI on 05.01.2021.
//  Copyright © 2021 IA. All rights reserved.
//

import UIKit

class XibView: UIView {

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        guard let xibView = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView else {
            return
        }
        addSubview(xibView)
        sendSubviewToBack(xibView)
        
        xibView.backgroundColor = backgroundColor
        xibView.translatesAutoresizingMaskIntoConstraints = false
        
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: xibView, attribute: $0, relatedBy: .equal, toItem: self, attribute: $0, multiplier: 1, constant: 0)
        })
    }
}
