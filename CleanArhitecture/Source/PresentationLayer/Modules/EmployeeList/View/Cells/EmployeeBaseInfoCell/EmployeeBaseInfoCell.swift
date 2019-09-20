//
//  EmployeeBaseInfoCell.swift
//  CleanArhitecture
//
//  Created by MSI on 03/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import UIKit

class EmployeeBaseInfoCell: EmployeeBaseCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specializationLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func updateViews() {
        guard let model = model as? EmployeeBaseInfoCellModel else {
            return
        }
        
        nameLabel.text = model.name
        specializationLabel.text = model.specialization
        photoImageView.af_setImage(withURL: model.imageURL)
    }
}




