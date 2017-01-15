//
//  FancyView.swift
//  Blu Social
//
//  Created by Blu on 1/15/17.
//  Copyright © 2017 Blu. All rights reserved.
//

import UIKit

class FancyView: UIView {


    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: BLACK, green: BLACK, blue: BLACK, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
    }
    
    
}
