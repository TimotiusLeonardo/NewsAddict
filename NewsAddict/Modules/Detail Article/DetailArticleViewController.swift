//
//  CategoriesViewController.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import UIKit
import WebKit

protocol DetailArticleViewDelegate: AnyObject {
    func didGetDetailArticleData(data: DetailArticleModel?)
}

class DetailArticleViewController: UIViewController, DetailArticleViewDelegate {
    
    // MARK: - View Components
    var webView: WKWebView?
    var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.color = .black
        view.hidesWhenStopped = true
        return view
    }()
    
    // MARK: - Variables
    var presenter: DetailArticleViewToPresenterDelegate?
    var articles: ArticlesModel?
    
    override func loadView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getDetailArticleData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
    }
    
    // MARK: - Private Function
    private func setupUI() {
        view.addSubview(loadingView)
        loadingView.anchor(top: nil,
                           leading: nil,
                           bottom: nil,
                           trailing: nil,
                           padding: .zero,
                           size: .init(width: 24, height: 24))
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.startAnimating()
        
        webView?.allowsBackForwardNavigationGestures = true
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadWebView))
        toolbarItems = [refresh]
        navigationController?.isToolbarHidden = false
        view.backgroundColor = .white
    }
    
    func didGetDetailArticleData(data: DetailArticleModel?) {
        guard let url = data?.url else {
            return
        }
        webView?.load(URLRequest(url: url))
    }
    
    @objc func didBackButtonClicked() {
        presenter?.dismiss()
    }
    
    @objc func reloadWebView() {
        loadingView.startAnimating()
        webView?.reload()
    }

}

extension DetailArticleViewController: UITableViewDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingView.stopAnimating()
        title = webView.title
    }
}
