//
//  progressTVC.swift
//  My progress
//
//  Created by Kovs on 29.07.2022.
//

import UIKit

class progressTVC: UITableViewCell {
    
    let progressName = UILabel()
    // progress:
    let progress = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        progressName.translatesAutoresizingMaskIntoConstraints = false
        progressName.font = UIFont.systemFont(ofSize: 20)
        
        contentView.addSubview(progressName)
        
        NSLayoutConstraint.activate([
            progressName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            progressName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            progressName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            progressName.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
