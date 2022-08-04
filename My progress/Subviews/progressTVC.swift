//
//  progressTVC.swift
//  My progress
//
//  Created by Kovs on 29.07.2022.
//

import UIKit
import SnapKit

class progressTVC: UITableViewCell {
    
    let progressName = UILabel()
    // progress:
    let progress = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        progressName.translatesAutoresizingMaskIntoConstraints = false
        progress.translatesAutoresizingMaskIntoConstraints = false
        
        
        progressName.font = UIFont.systemFont(ofSize: 20)
        progress.backgroundColor = .black
        
        // contentView.addSubview(progressName)
        addSubview(progressName)
        addSubview(progress)
        
        progress.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-20)
            make.top.equalTo(25)
            make.bottom.equalTo(-25)
            make.width.equalTo(50)
            // make.height.equalTo(50)
        }
        
        progressName.snp.makeConstraints { (make) -> Void in
            //make.left.equalTo(20)
            // make.height.equalTo(50)
            make.left.top.equalTo(20)
            make.bottom.equalTo(-20)
            make.right.equalTo(progress.snp.left).offset(-20)
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
