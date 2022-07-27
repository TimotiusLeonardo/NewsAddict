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
    
    // MARK: - Variables
    var presenter: SourcesViewToPresenterDelegate?
    var sources: SourcesModel?

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
        navigationController?.isToolbarHidden = true
        view.backgroundColor = .white
    }
    
    func didGetSourcesData(data: SourcesModel?) {
        sources = data
        sourcesTableView.reloadData()
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
