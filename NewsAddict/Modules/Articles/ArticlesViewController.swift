//
//  CategoriesViewController.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import UIKit

protocol ArticlesViewDelegate: AnyObject {
    func didGetArticlesData(data: ArticlesModel?)
}

class ArticlesViewController: UIViewController, ArticlesViewDelegate {
    
    // MARK: - View Components
    lazy var sourcesTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sources"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    lazy var backChevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(didBackButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var emptyTitle: UILabel = {
        let label = UILabel()
        label.text = "No Articles Found..."
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.alpha = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Variables
    var presenter: ArticlesViewToPresenterDelegate?
    var articles: ArticlesModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getArticlesData()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private Function
    private func setupUI() {
        view.addSubview(sourcesTableView)
        view.addSubview(pageTitleLabel)
        view.addSubview(backChevronButton)
        view.addSubview(emptyTitle)
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: nil,
                              trailing: view.trailingAnchor,
                              padding: .zero,
                              size: .init(width: 0, height: 80))
        sourcesTableView.anchor(top: pageTitleLabel.bottomAnchor,
                                 leading: view.leadingAnchor,
                                 bottom: view.bottomAnchor,
                                 trailing: view.trailingAnchor,
                                 padding: .zero,
                                 size: .zero)
        sourcesTableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: "Cell")
        backChevronButton.anchor(top: nil,
                                 leading: view.leadingAnchor,
                                 bottom: nil,
                                 trailing: nil,
                                 padding: .init(top: 0, left: 24, bottom: 0, right: 0),
                                 size: .init(width: 24, height: 24))
        backChevronButton.centerYAnchor.constraint(equalTo: pageTitleLabel.centerYAnchor).isActive = true
        emptyTitle.anchor(top: nil,
                          leading: view.leadingAnchor,
                          bottom: nil,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 0, left: 24,
                                         bottom: 0, right: 24),
                          size: .zero)
        emptyTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = .white
    }
    
    func didGetArticlesData(data: ArticlesModel?) {
        articles = data
        sourcesTableView.reloadData()
        if articles?.articles.isEmpty == true {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.emptyTitle.alpha = 1
            },
                           completion: nil)
        }
    }
    
    @objc func didBackButtonClicked() {
        presenter?.dismiss()
    }

}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = articles else {
            return 0
        }
        
        return model.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DefaultTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(text: articles?.articles[indexPath.row].title ?? "No Title",
                       subtitle: articles?.articles[indexPath.row].author ?? "No Author")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
