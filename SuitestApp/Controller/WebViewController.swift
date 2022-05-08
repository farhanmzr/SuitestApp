//
//  WebViewController.swift
//  SuitestApp
//
//  Created by Farhan Mazario on 02/05/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        
        guard let url = URL(string: "https://suitmedia.com/") else {return}
        webView.load(URLRequest(url: url))

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    @objc func dismissMe() {
        self.dismiss(animated: true)
    }

}
