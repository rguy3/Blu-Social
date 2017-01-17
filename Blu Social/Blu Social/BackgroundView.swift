//
//  BackgroundView.swift
//  Blu Social
//
//  Created by Blu on 1/16/17.
//  Copyright © 2017 Blu. All rights reserved.
//

import UIKit

class BackgroundView: UIView {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10.0
        layer.shadowOpacity = 1.0
        layer.shadowColor = UIColor(red: BLACK, green: BLACK, blue: BLACK, alpha: 0.2).cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

}
