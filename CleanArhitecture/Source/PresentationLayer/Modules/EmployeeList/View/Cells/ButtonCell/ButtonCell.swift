//
//  ButtonCell.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class ButtonCell: EmployeeBaseCell {
    @IBOutlet weak var button: UIButton!
    
    override func updateViews() {
        guard  let model = model as? ButtonCellModel else {
            return
        }
        
        button.setTitle(model.title, for: .normal)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        guard  let model = model as? ButtonCellModel else {
            return
        }
        
        model.action?()
    }
}
