//
//  WebViewController.swift
//  InstagramClone
//
//  Created by Артём Балашов on 04/01/2019.
//  Copyright © 2019 Артём Балашов. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var webView: UIWebView!
    
    //MARK: - Properties
    var URL: URL!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.loadRequest(URLRequest.init(url: URL))
    }

}

extension WebViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        print(request.url?.host)
        if let url = request.url, ("\(url.scheme ?? "")://\(url.host ?? "")".contains(redirectURI)) == true {
            guard let token = url.queryParameters?["access_token"] else {return true}
            APItoken = token
            navigationController?.popViewController(animated: true)
        }
        return true
    }
}
