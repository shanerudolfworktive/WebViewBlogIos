//
//  ViewController.swift
//  WebViewBlogIos
//
//  Created by Shane Rudolf on 1/16/18.
//  Copyright © 2018 Shane. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class ViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {
    var webView : WKWebView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = WKUserContentController()
        controller.add(self, name: "iosApp")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = controller
        
        webView = WKWebView(frame: self.view.frame, configuration: configuration)
        let url = Bundle.main.url(forResource: "WebViewBlog", withExtension: "html")
        let request = URLRequest(url: url!)
        self.view.addSubview(webView!)
        webView?.load(request)
        
        webView?.navigationDelegate = self
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Message from Javascript: \(message.body)")
        let platform = UIDevice.current.model;
        let osVersion = UIDevice.current.systemVersion;
        webView?.evaluateJavaScript("renderOSVersion('\(platform) : \(osVersion)')", completionHandler: nil)
    }
}


