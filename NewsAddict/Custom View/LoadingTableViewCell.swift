//
//  LoadingTableViewCell.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 27/07/22.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    // MARK: View Components
    var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.color = .black
        view.hidesWhenStopped = true
        view.startAnimating()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(loadingView)
        loadingView.anchor(top: nil,
                           leading: nil,
                           bottom: nil,
                           trailing: nil,
                           padding: .zero,
                           size: .init(width: 24, height: 24))
        loadingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
}
