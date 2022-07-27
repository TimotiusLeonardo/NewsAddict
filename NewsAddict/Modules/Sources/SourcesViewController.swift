//
//  CategoriesViewController.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import UIKit

protocol SourcesViewDelegate: AnyObject {
    func didGetSourcesData(data: SourcesModel?)
}

class SourcesViewController: UIViewController, SourcesViewDelegate {
    
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
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Articles"
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var emptyTitle: UILabel = {
        let label = UILabel()
        label.text = "No Sources Found..."
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.alpha = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Variables
    var presenter: SourcesViewToPresenterDelegate?
    var sources: SourcesModel?
    var originalSourcesFromAPI: SourcesModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getSourcesData()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private Function
    private func setupUI() {
        view.addSubview(sourcesTableView)
        view.addSubview(pageTitleLabel)
        view.addSubview(backChevronButton)
        view.addSubview(searchBar)
        view.addSubview(emptyTitle)
        pageTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: nil,
                              trailing: view.trailingAnchor,
                              padding: .zero,
                              size: .init(width: 0, height: 80))
        sourcesTableView.anchor(top: searchBar.bottomAnchor,
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
        searchBar.anchor(top: pageTitleLabel.bottomAnchor,
                         leading: view.leadingAnchor,
                         bottom: nil,
                         trailing: view.trailingAnchor,
                         padding: .zero,
                         size: .init(width: 0, height: 60))
        emptyTitle.anchor(top: nil,
                          leading: view.leadingAnchor,
                          bottom: nil,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 0, left: 24,
                                         bottom: 0, right: 24),
                          size: .zero)
        emptyTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        navigationController?.isToolbarHidden = true
        view.backgroundColor = .white
    }
    
    func didGetSourcesData(data: SourcesModel?) {
        sources = data
        originalSourcesFromAPI = data
        sourcesTableView.reloadData()
    }
    
    func refreshData() {
        sources = nil
        sourcesTableView.reloadData()
    }
    
    func toggleEmptyLabel() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.emptyTitle.alpha = self.sources?.sources.isEmpty == true ? 1 : 0
        },
                       completion: nil)
    }
    
    @objc func didBackButtonClicked() {
        presenter?.dismiss()
    }

}

extension SourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = sources else {
            return 0
        }
        
        return model.sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DefaultTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(text: sources?.sources[indexPath.row].name ?? "No Name")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let sourceId = sources?.sources[indexPath.row].id else {
            return
        }
        presenter?.goToArticlesList(source: sourceId)
    }
}

extension SourcesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        refreshData()
        sources = presenter?.sortDataBasedOnKeyword(keywords: searchBar.text ?? "", model: originalSourcesFromAPI)
        sourcesTableView.reloadData()
        toggleEmptyLabel()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.resignFirstResponder()
            refreshData()
            sources = originalSourcesFromAPI
            sourcesTableView.reloadData()
            toggleEmptyLabel()
        }
    }
}
