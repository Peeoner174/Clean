//
//  AdressCell.swift
//  CleanArhitecture
//
//  Created by Pavel Kochenda on 22.12.2020.
//  Copyright © 2020 IA. All rights reserved.
//

import UIKit

struct AddressModel {
    let address: String
    var number: UInt8
}

class AddressCell: UITableViewCell {
    @IBOutlet weak var addressLabel: UILabel!
    private var didTapRemoveButton: EmptyCompletion = nil
    
    func configure(model: AddressModel, forIndexPath indexPath: IndexPath, didTapRemoveButton: EmptyCompletion) {
        let numberText = "\(indexPath.row + 1)" + "."
        let numberAttributedText: AttributedString = "\(numberText, color: UIColor.black.withAlphaComponent(0.7))"
        let addressAttributedText: AttributedString = "\(model.address, color: .black)"
        
        self.addressLabel.attributedText = numberAttributedText.value + NSAttributedString(string: " ") + addressAttributedText.value
        self.didTapRemoveButton = didTapRemoveButton
    }
    
    @IBAction func removeAction(_ sender: Any) {
        didTapRemoveButton?()
    }
}
