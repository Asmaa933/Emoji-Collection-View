//
//  CollectionViewCell.swift
//  Collection View
//
//  Created by Asmaa on 2/23/19.
//  Copyright © 2019 Asmaa. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionImage: UIImageView!
   
    var isEditing: Bool = false {
        didSet{
            selectionImage.isHidden = !isEditing
        }
    }
    override var isSelected: Bool {
        didSet{
            if isEditing {
                selectionImage.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")

            }
        }
    }
}
