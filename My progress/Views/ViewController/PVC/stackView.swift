//
//  stackView.swift
//  My progress
//
//  Created by Kovs on 23.11.2022.
//

import UIKit
import SnapKit

extension UIStackView {
    
    func makeStackView() {
        self.axis = .vertical
        self.spacing = 20
        self.alignment = .center
        self.distribution = .equalSpacing
        
        
    }
    
    func placeStackView(view: UIView, scrollPage: UIScrollView) {
        self.snp.makeConstraints { (stack) -> Void in
            stack.top.equalTo(scrollPage.snp.top).offset(50)
            stack.leading.equalTo(view.snp.leading).offset(20)
            stack.bottom.equalTo(scrollPage)
            // stack.width.equalTo(scrollPage.snp.width).offset(-40)
            stack.centerX.equalToSuperview()
        }
    }
}
