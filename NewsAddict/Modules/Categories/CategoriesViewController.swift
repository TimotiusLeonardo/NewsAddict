//
//  CategoriesViewController.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import UIKit

protocol CategoriesViewDelegate: AnyObject {
    func updateCategory(_ data: [CategoriesModel])
}

class CategoriesViewController: UIViewController, CategoriesViewDelegate {
    
    // MARK: - View Components
    lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Categories"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    // MARK: - Variables
    var presenter: CategoriesViewToPresenterDelegate?
    var category: [CategoriesModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getCategoryData()
        // Do any additional setup after loading the view.
    }
    
    func updateCategory(_ data: [CategoriesModel]) {
        category = data
        categoryTableView.reloadData()
    }
    
    // MARK: - Private Function
    private func setupUI() {
        view.addSubview(categoryTableView)
        view.addSubview(pageTitleLabel)
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                 leading: view.leadingAnchor,
                                 bottom: nil,
                                 trailing: view.trailingAnchor,
                                 padding: .zero,
                              size: .init(width: 0, height: 80))
        categoryTableView.anchor(top: pageTitleLabel.bottomAnchor,
                                 leading: view.leadingAnchor,
                                 bottom: view.bottomAnchor,
                                 trailing: view.trailingAnchor,
                                 padding: .zero,
                                 size: .zero)
        categoryTableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.backgroundColor = .white
    }

}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DefaultTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(text: category[indexPath.row].name.rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
