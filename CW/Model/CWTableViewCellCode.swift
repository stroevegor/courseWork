//
//  CWTableViewCellCode.swift
//  CW
//
//  Created by Роман Шуркин on 07.06.2020.
//  Copyright © 2020 Stroev Egor. All rights reserved.
//

import Foundation
import UIKit

class CWTableViewCellCode: UITableViewCell {
    
    private var nameLabel = UILabel()
    private var districtLabel = UILabel()
    private var paymentLabel = UILabel()
    private var contentLabel = UILabel()
    private var btn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        self.setUp()
       
    }

   required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        
        self.addSubview(self.btn)
        
        self.btn.titleLabel?.text = "Принять"
        
        self.btn.tintColor = .green
        
        self.btn.topAnchor.constraint(equalToSystemSpacingBelow: self.nameLabel.bottomAnchor, multiplier: 20)
       
        self.addSubview(nameLabel)

        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
       

        self.addSubview(districtLabel)

        self.districtLabel.translatesAutoresizingMaskIntoConstraints = false
        self.districtLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 20).isActive = true
        self.districtLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true


        self.addSubview(paymentLabel)

        self.paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.paymentLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 15).isActive = true
        self.paymentLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40).isActive = true

        self.addSubview(contentLabel)

        self.contentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentLabel.topAnchor.constraint(equalTo: self.districtLabel.bottomAnchor, constant: 30).isActive = true
        self.contentLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.contentLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true


    }
    
    func configure(_ name: String, _ ds: String, _ payment: String, _ content: String) {
        
        self.nameLabel.text = name
        self.districtLabel.text = ds
        self.paymentLabel.text = payment
        self.contentLabel.text = content
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
}
