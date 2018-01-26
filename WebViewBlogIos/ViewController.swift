//
//  ViewController.swift
//  WebViewBlogIos
//
//  Created by Shane Rudolf on 1/16/18.
//  Copyright © 2018 Shane. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var webview : BlogWKWebView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        webview = BlogWKWebView(frame: self.view.frame)
        let u = "https://shanerudolfworktive.github.io/WebViewBlogHtml/WebViewBlogPart2"
        let request = URLRequest(url: URL(string: u)!)
        webview.load(request)
        self.view.addSubview(webview)
        
        webview.exposeFunctionToJS(functionName: "workforce", function: renderJob)
        webview.exposeFunctionToJS(functionName: "identity", function: renderIdentity)
    }
    
    public func renderJob(params : [String: Any]?){
        let title = params?["title"] as! String
        webview.invokeJavascript(message: "I work as \(title)")
    }
    
    public func renderIdentity(params : [String: Any]?){
        let name = params?["name"] as! String
        let age = params?["age"] as! Int
        webview.invokeJavascript(message: "my name is \(name) and I am \(age) years old")
    }
}
