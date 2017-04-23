//
//  LoginViewController.swift
//  BookList
//
//  Created by chenzhongsong on 16/4/15.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(NSURLRequest(URL: NSURL(string: NetManager.OAuthLogin.URLStringGetCode)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIWebViewDelegate -
    //加载webView请求之前回调这个方法   返回是否加载这个请求
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // 服务器又返回了一个URL https://www.baidu.com/?code=42f3b6f4b44bc14e
        
        if let URLString = request.URL?.absoluteString {
            print(URLString)
            if URLString.hasPrefix(NetManager.OAuthLogin.redirect_uri) {
                if let range = URLString.rangeOfString("?code=") {
                    let code = URLString.substringFromIndex(range.endIndex)
                    
                    NetManager.OAuthLogin.loginWithCode(code, resultColsure: { (result) -> Void in
                        
                        if result {
                            self.view.window?.makeToast("Login Success")
                            self.navigationController?.popViewControllerAnimated(true)
                        } else {
                            self.view.makeToast("Login Fail")
                        }
                    })
                }
            }
        }
        
        return true
    }
    

    @IBAction func back(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBOutlet weak var back: UIButton!
}







































