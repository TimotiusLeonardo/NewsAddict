//
//  DefaultTableViewCell.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 27/07/22.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        
        textLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        textLabel?.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(text: String) {
        textLabel?.text = text
    }

}
