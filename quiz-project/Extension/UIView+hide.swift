//
//  UIView+hide.swift
//  tms-25-zeroview-xib
//
//  Created by Artur Igberdin on 18.11.2022.
//

import UIKit

extension UIView {
    
    func hide() {
        guard !isHidden else { return }
        isHidden = true
    }
    
    func show() {
        guard isHidden else { return }
        isHidden = false
    }
}
