//
//  CGRect + Ext.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 19.11.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

extension CGSize {
    static var fullscreen = UIScreen.main.bounds.size
    static var halfScreen = CGSize(width: UIScreen.main.bounds.size.width / 2, height: UIScreen.main.bounds.size.height / 2)
}

extension CGRect {
    static var fullscreen = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    
    static var halfScreen = CGRect(x: 0, y: UIScreen.main.bounds.size.height / 2, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height / 2)
}

