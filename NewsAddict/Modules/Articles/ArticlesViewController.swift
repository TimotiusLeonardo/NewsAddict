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
    
    enum TableViewSection {
        case loadingBar
        case contentCell
    }
    
    // MARK: - View Components
    lazy var sourcesTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Articles"
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
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Articles"
        searchBar.delegate = self
        return searchBar
    }()
    
    // MARK: - Variables
    var presenter: ArticlesViewToPresenterDelegate?
    var articles: ArticlesModel?
    var sections: [TableViewSection] = [
        .contentCell, .loadingBar
    ]
    var isFullLoaded: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getArticlesData(withKeyword: nil)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private Function
    private func setupUI() {
        view.addSubview(sourcesTableView)
        view.addSubview(pageTitleLabel)
        view.addSubview(backChevronButton)
        view.addSubview(emptyTitle)
        view.addSubview(searchBar)
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: nil,
                              trailing: view.trailingAnchor,
                              padding: .zero,
                              size: .init(width: 0, height: 80))
        searchBar.anchor(top: pageTitleLabel.bottomAnchor,
                         leading: view.leadingAnchor,
                         bottom: nil,
                         trailing: view.trailingAnchor,
                         padding: .zero,
                         size: .init(width: 0, height: 60))
        sourcesTableView.anchor(top: searchBar.bottomAnchor,
                                 leading: view.leadingAnchor,
                                 bottom: view.bottomAnchor,
                                 trailing: view.trailingAnchor,
                                 padding: .zero,
                                 size: .zero)
        sourcesTableView.register(DefaultTableViewCell.self, forCellReuseIdentifier: "Cell")
        sourcesTableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: "LoadingCell")
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        view.backgroundColor = .white
    }
    
    func didGetArticlesData(data: ArticlesModel?) {
        if articles == nil {
            articles = data
            isFullLoaded = false
        } else {
            articles?.articles.append(contentsOf: data?.articles ?? [])
            isFullLoaded = false
        }
        // if already at bottom page, make loading cell dissapear
        if data?.articles.isEmpty == true || data == nil {
            isFullLoaded = true
        }
        
        sourcesTableView.reloadData()
        
        // If list empty, show empty label
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
    
    func refreshData() {
        articles = nil
        sourcesTableView.reloadData()
        
        if emptyTitle.alpha == 1 {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.emptyTitle.alpha = 0
            },
                           completion: nil)
        }
    }
    
    @objc func didBackButtonClicked() {
        presenter?.dismiss()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .loadingBar:
            return isFullLoaded ? 0 : 1
        case .contentCell:
            guard let model = articles else {
                return 0
            }
            
            return model.articles.count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let _ = cell as? LoadingTableViewCell, indexPath.section == 1, indexPath.row == 0 else {
            return
        }
        print("Display Loading Cell")
        presenter?.getArticlesData(withKeyword: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .loadingBar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingTableViewCell else {
                return UITableViewCell()
            }
            cell.loadingView.startAnimating()
            return cell
        case .contentCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DefaultTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(text: articles?.articles[indexPath.row].title ?? "No Title",
                           subtitle: articles?.articles[indexPath.row].author ?? "No Author")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch sections[indexPath.section] {
        case .loadingBar:
            print("Nothing To do")
        case .contentCell:
            presenter?.goToDetailArticlePage(article: articles?.articles[indexPath.row])
        }
    }
}

extension ArticlesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        refreshData()
        presenter?.getArticlesData(withKeyword: searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.resignFirstResponder()
            refreshData()
            presenter?.getArticlesData(withKeyword: searchText)
            sourcesTableView.reloadData()
        }
    }
}
