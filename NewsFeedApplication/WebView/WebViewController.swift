//
//  WebViewViewController.swift
//  MVPModel
//
//  Created by Дмитрий Пономарев on 04.02.2023.
//

import UIKit
import WebKit


class WebViewViewController: UIViewController {
    
    //  MARK: - UI properties
    
    private let webView = WKWebView()
    private let url: URL
    
    //  MARK: - Init
    
    init(url: URL, title: String) {
        self.url = url
        super .init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
    
    //  MARK: - viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
