//
//  DefaultTableViewCell.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 27/07/22.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
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
    
    func configure(text: String, subtitle: String? = nil, imageUrl: String? = nil) {
        textLabel?.text = text
        textLabel?.numberOfLines = 0
        if let _imageView = imageView,
            let _imageUrl = imageUrl,
           let url = URL(string: _imageUrl) {
            _imageView.contentMode = .scaleAspectFill
            _imageView.downloadImage(from: url)
        }
        guard let subtitle = subtitle else {
            return
        }
        textLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        detailTextLabel?.text = subtitle
        detailTextLabel?.font = .systemFont(ofSize: 12, weight: .light)
    }

}
