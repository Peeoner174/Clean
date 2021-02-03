//
//  PopOverContainerView.swift
//  CleanArhitecture
//
//  Created by MSI on 05/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class PopoverContainerViewBuilder {
    private var nodes: [UIView] = []
    
    func add(node: UIView) -> PopoverContainerViewBuilder {
        self.nodes.append(node)
        return self
    }

    func add(optionalNode node: UIView?) -> PopoverContainerViewBuilder {
        guard let node = node else { return self }
        self.nodes.append(node)
        return self
    }
    
    func build(withFrame frame: CGRect) -> PopoverContainerView {
        return PopoverContainerView(frame: frame, nodes: self.nodes)
    }
}

class PopoverContainerView: UIView {
    
    private weak var stackView: UIStackView!
    
    init(frame: CGRect, nodes: [UIView]) {
        super.init(frame: frame)
        
        self.createStackView(with: frame)
        nodes.compactMap { $0 }.forEach { view in
            self.stackView.addArrangedSubview(view)
        }
    }
    
    private func createStackView(with frame: CGRect) {
        let stack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 8.0
            return stack
        }()
        addSubview(stack)
        stack.fillSuperview()
        self.stackView = stack
    }
    
//    init(presentedView: UIView, frame: CGRect, dragIndicatorView: UIView? = nil) {
//        super.init(frame: frame)
//        addSubview(presentedView)
//        guard let dragIndicatorView = dragIndicatorView else { return }
//        presentedView.addSubview(dragIndicatorView, constraints: [
//            equal(\.bottomAnchor, to: presentedView, \.topAnchor, constant: -8.0),
//            equal(\.leadingAnchor, to: presentedView),
//            equal(\.trailingAnchor, to: presentedView),
//        ])
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

