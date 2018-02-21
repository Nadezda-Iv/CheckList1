//
//  HeaderView.swift
//  CheckList
//
//  Created by MacBook Pro on 05.02.2018.
//  Copyright © 2018 dev.ios. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toogleSection (header: ExpandableHeaderView, section: Int)
    
}


class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderView)))
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderView)))
    }
    
    
    
    @objc func selectHeaderView(gesture: UITapGestureRecognizer) {
        let cell = gesture.view as!  ExpandableHeaderView
        delegate?.toogleSection(header: self, section: cell.section)
    }
    
    func customInit(title: String, subtitle: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.textColor = UIColor.white
        self.subtitleLabel?.textColor = UIColor.white
        self.subtitleLabel?.alpha = 0.7
        self.contentView.backgroundColor = UIColor.darkGray
        
}
}











