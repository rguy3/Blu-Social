//
//  FancyText.swift
//  Blu Social
//
//  Created by Blu on 1/15/17.
//  Copyright © 2017 Blu. All rights reserved.
//

import UIKit

class FancyText: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect { //Edits bounds for text
        return bounds.insetBy(dx: 5, dy: 0) //Inset text by x
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect { //Edits bounds on select
        return bounds.insetBy(dx: 5, dy: 0)
    }

}
