//
//  BlogWKWebView.swift
//  WebViewBlogIos
//
//  Created by Shane Rudolf on 1/24/18.
//  Copyright © 2018 Shane. All rights reserved.
//

import UIKit
import WebKit

class BlogWKWebView: WKWebView, WKScriptMessageHandler {
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        configuration.userContentController.add(self, name: "iosApp")
    }
    convenience init(frame: CGRect) {
        self.init(frame: frame, configuration: WKWebViewConfiguration())
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    var functions = [String : ([String: Any]?)->Void]()

    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        let dict = convertJsonToDictionary(text: String(describing:message.body))
        functions[String(describing: dict!["functionName"]!)]?(dict)
    }
    
    public func exposeFunctionToJS(functionName: String,
                                   function: @escaping ([String: Any]?)->Void){
        functions[functionName] = function
    }
    
    func convertJsonToDictionary(text: String) -> [String: Any]? {
        let data = text.data(using: .utf8)!
        do{return
            try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        }catch {return nil}
    }
    
    func invokeJavascript(message:String){
        evaluateJavaScript("render('\(message)')", completionHandler: nil)
    }
}
