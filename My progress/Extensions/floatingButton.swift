//
//  floatingButton.swift
//  My progress
//
//  Created by Kovs on 23.11.2022.
//

import UIKit
import SnapKit

extension UIButton {
    
    func makeFloatingButton() {
        self.setTitle("Add", for: .normal)
        self.backgroundColor = .black
        self.layer.cornerRadius = 30

        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func placeFloatingButton(view: UIView) {
        self.snp.makeConstraints { (button) -> Void in
            button.width.equalTo(60)
            button.height.equalTo(60)
            
            button.bottom.equalTo(view.snp.bottom).offset(-30)
            button.trailing.equalTo(view.snp.trailing).offset(-20)
        }
    }
    
}
