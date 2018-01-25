//
//  ViewController.swift
//  WebViewBlogIos
//
//  Created by Shane Rudolf on 1/16/18.
//  Copyright © 2018 Shane. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
    var webview : WKWebView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview = WKWebView(frame: self.view.frame, configuration: WKWebViewConfiguration())
        webview.configuration.userContentController.add(self, name: "iosApp")
        
        let url = Bundle.main.url(forResource: "WebViewBlog", withExtension: "html")
        let request = URLRequest(url: url!)
        self.view.addSubview(webview)
        webview.load(request)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Message from Javascript: \(message.body)")
        let platform = UIDevice.current.model
        let osVersion = UIDevice.current.systemVersion
        invokeJavascript(message: "\(platform) : \(osVersion)")
    }
    
    func invokeJavascript(message:String){
        webview.evaluateJavaScript("render('\(message)')", completionHandler: nil)
    }
}


